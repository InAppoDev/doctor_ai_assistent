import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:ecnx_ambient_listening/core/models/transcription_model/transcription_model.dart';
import 'package:ecnx_ambient_listening/core/services/auth_service/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WebSocketService {
  WebSocket? _rawSocket; // For sending
  late Stream<dynamic> _socketStream; // For listening (broadcast)
  final SharedPreferences _prefs;

  WebSocketService({
    required SharedPreferences prefs,
  }) : _prefs = prefs;

  AuthService get _authService => AuthService(_prefs);

  Completer<String>? _keyCompleter;

  String transcribedText = '';
  Function(String)? onTranscription;
  bool isConnected = false;
  bool getKey = false;

  /// Connect to WebSocket and create a broadcast stream
  Future<void> connect() async {
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
      _rawSocket = await WebSocket.connect(
        'wss://ecnx.org/ws/transcribe/?token=$token&language=$language',
      );
      _socketStream =
          _rawSocket!.asBroadcastStream(); // Now listenable multiple times
      isConnected = true;
      print('WebSocket connected.');
    } catch (e) {
      print('Error connecting to WebSocket: $e');
    }
  }

  /// Add a listener to the WebSocket broadcast stream
  void socketListener({
    required Function(TranscriptionModel) onTranscript,
    required Function(String) onKey,
  }) {
    if (_rawSocket == null) {
      print('❌ WebSocket not initialized');
      return;
    }

    _socketStream.listen(
      (message) {
        print('Received message: $message');
        _handleMessage(message, onTranscript, onKey);
      },
      onError: (error) {
        print('WebSocket error: $error');
      },
      onDone: () {
        print('WebSocket closed.');
        isConnected = false;
      },
    );
  }

  /// Trigger the backend to send the audio key
  /// Sends "write" and waits for the "key" from server
  Future<String> requestAudioKey() {
    if (!isConnected || _rawSocket == null) {
      throw Exception('WebSocket not connected.');
    }

    _keyCompleter = Completer<String>();
    _rawSocket!.add('write');
    return _keyCompleter!.future;
  }

  /// Send audio data
  void sendText(Uint8List ms) {
    getKey = false;
    if (!isConnected) {
      print('❌ Not connected to WebSocket.');
      return;
    }

    try {
      _rawSocket?.add(ms);
    } catch (e, s) {
      print('Error sending binary data: $e\nStack: $s');
    }
  }

  /// Handles incoming WebSocket messages
  void _handleMessage(
    dynamic message,
    Function(TranscriptionModel) onTranscript,
    Function(String) onKey,
  ) {
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
                  final buffer = StringBuffer();
                  int? speaker;
                  double? time;

                  for (var item in items) {
                    final type = item['Type'];
                    final content = item['Content'];

                    // Get speaker only once
                    if (speaker == null &&
                        type == 'pronunciation' &&
                        item.containsKey('Speaker')) {
                      final speakerRaw = item['Speaker'];
                      if (speakerRaw is int) {
                        speaker = speakerRaw;
                      } else if (speakerRaw is String) {
                        speaker = int.tryParse(speakerRaw);
                      }
                    }

                    // ✅ Get StartTime only once
                    if (time == null &&
                        type == 'pronunciation' &&
                        item.containsKey('StartTime')) {
                      final startRaw = item['StartTime'];
                      if (startRaw is num) {
                        time = startRaw.toDouble();
                      } else if (startRaw is String) {
                        time = double.tryParse(startRaw);
                      }
                    }

                    if (type == 'pronunciation') {
                      buffer.write('$content ');
                    } else if (type == 'punctuation') {
                      buffer.write('$content ');
                    }
                  }

                  final transcript = buffer.toString().trim();

                  onTranscript(
                    TranscriptionModel(
                      speaker: speaker ?? 0,
                      transcription: transcript,
                      time: time ?? 0,
                    ),
                  );
                }
              }
            }
          }
        }
      }

      // ✅ Updated this block as well
      else if (decoded is Map<String, dynamic>) {
        final transcript = decoded['Transcript']?.toString().trim();
        final speakerRaw = decoded['Speaker'];
        final startTimeRaw = decoded['StartTime'];

        int speaker = 0;
        double time = 0;

        if (speakerRaw is int) {
          speaker = speakerRaw;
        } else if (speakerRaw is String) {
          speaker = int.tryParse(speakerRaw) ?? 0;
        }

        if (startTimeRaw is num) {
          time = startTimeRaw.toDouble();
        } else if (startTimeRaw is String) {
          time = double.tryParse(startTimeRaw) ?? 0;
        }

        if (transcript != null && transcript.isNotEmpty) {
          onTranscript(
            TranscriptionModel(
              speaker: speaker,
              transcription: transcript,
              time: time,
            ),
          );
        } else if (decoded.containsKey('key')) {
          final key = decoded['key'].toString();
          if (_keyCompleter != null && !_keyCompleter!.isCompleted) {
            _keyCompleter!.complete(key);
            _keyCompleter = null;
          }
          onKey(key);
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

  /// Close the socket
  void close() {
    if (isConnected) {
      _rawSocket?.close();
      isConnected = false;
    }
  }
}
