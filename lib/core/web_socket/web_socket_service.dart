import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ecnx_ambient_listening/core/services/auth_service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebSocketService {
  WebSocket? _socket;
  final SharedPreferences _prefs;

  WebSocketService({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  AuthService get _authService => AuthService(_prefs);

  String transcribedText = '';
  Function(String)? onTranscription;
  bool isConnected = false;

  Future<void> connect(Function(String) onMessageCome) async {
    if (!await _authService.isAccessTokenValid()) {
      print('🔄 Token expired or about to expire. Attempting refresh...');
      final refreshed = await _authService.refreshTokenAction();
      if (!refreshed) {
        print('❌ Failed to refresh token. Aborting WebSocket connection.');
        return;
      }
    }

    final token = _authService.accessToken;

    if (token == null) {
      print('❌ No access token. Aborting WebSocket connection.');
      return;
    }
    final language =
        PlatformDispatcher.instance.locale.toString().replaceAll('_', '-');

    try {
      print('Connecting with token: $token');
      _socket = await WebSocket.connect(
        'wss://ecnx.org/ws/transcribe/?token=$token&language=$language',
      );

      isConnected = true;
      print('WebSocket connected.');

      _socket!.listen(
        (message) {
          print('Received message: $message');
          _handleMessage(message, onMessageCome);
        },
        onError: (error) {
          print('WebSocket error: $error');
        },
        onDone: () {
          print('WebSocket closed.');
          isConnected = false;
        },
      );
    } catch (e) {
      print('Error connecting to WebSocket: $e');
    }
  }

  void sendText(Uint8List ms) {
    if (!isConnected) {
      print('Not connected to WebSocket.');
      return;
    }

    try {
      print('message: $ms');
      _socket!.add(ms);
    } catch (e, s) {
      print('Error sending binary data: $e\nStack: $s');
    }
  }

  void _handleMessage(dynamic message, Function(String) onMessageCome) {
    try {
      final decoded = json.decode(message);
      print('Decoded message - $decoded');

      if (decoded is List) {
        for (var entry in decoded) {
          if (entry is Map && entry.containsKey('Alternatives')) {
            final alternatives = entry['Alternatives'];
            if (alternatives is List && alternatives.isNotEmpty) {
              final firstAlternative = alternatives.first;
              if (firstAlternative is Map &&
                  firstAlternative.containsKey('Items')) {
                final items = firstAlternative['Items'];
                if (items is List) {
                  final transcript = items
                      .where((item) =>
                          item['Type'] == 'pronunciation' ||
                          item['Type'] == 'punctuation')
                      .map<String>((item) => item['Content'].toString())
                      .join(' ');
                  print('Transcript: $transcript');
                  onMessageCome(transcript);
                }
              }
            }
          }
        }
      } else if (decoded is Map<String, dynamic>) {
        if (decoded.containsKey('Transcript')) {
          final transcribedText = decoded['Transcript'];
          print('Transcript (Map): $transcribedText');
          onMessageCome(transcribedText.toString());
        } else {
          print('Transcript key not found in Map.');
        }
      } else {
        print('Unexpected data type: ${decoded.runtimeType}');
      }
    } catch (e, s) {
      print('Error parsing message: $e, stack - $s');
    }
  }

  void close() {
    if (isConnected) {
      _socket!.close();
      isConnected = false;
    }
  }
}
