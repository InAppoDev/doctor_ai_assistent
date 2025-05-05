import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService {
  late WebSocketChannel _channel;
  String transcribedText = '';
  Function(String)? onTranscription;
  bool isConnected = false;
  final client = HttpClient()
    ..badCertificateCallback = (X509Certificate cert, String host, int port) {
      // Accept all certificates
      return true;
    };

  // Connect to WebSocket
  Future<void> connect(String token) async {
    try {
      print('Connecting with token: $token');
      final socket = await WebSocket.connect(
        'wss://44.223.62.35/ws/transcribe/?token=$token',
        customClient: client,
      );

      print('isBroadcast - ${socket.isBroadcast}');

      _channel = IOWebSocketChannel(socket);
      print('_channel - ${_channel.cast()}');
      isConnected = true;
      // Listen to incoming messages from WebSocket server
      _channel.stream.listen(
        (message) {
          print('isConnected - $isConnected');
          print('Raw message from server: $message');
          _handleMessage(message);
        },
        onError: (error) {
          print('WebSocket error: $error');
        },
        onDone: () {
          print('WebSocket closed by server');
        },
      );
    } catch (e) {
      print('Error connecting to WebSocket: $e');
    }
  }

  // Handle messages received from WebSocket
  void _handleMessage(String message) {
    print('WebSocket message: $message');
    try {
      final data = json.decode(message);
      print('WebSocket data: $data');
      if (data['status'] == 'success') {
        transcribedText = data['transcript'];
        if (onTranscription != null) {
          onTranscription!(transcribedText);
        }
      }
    } catch (e) {
      print('Error decoding WebSocket message: $e');
    }
  }

  // Send text as binary (UTF-8 encoded bytes)
  void sendText(String text) {
    if (isConnected) {
      try {
        print(
            'Text to send as binary: text $text; binary - ${Uint8List.fromList(utf8.encode(text))}');
        _channel.sink.add(Uint8List.fromList(utf8.encode(text)));
      } catch (e, s) {
        print('Error sending text via WebSocket: $e; stack - $s');
      }
    }
  }

  // Close the WebSocket connection
  void close() async {
    try {
      await _channel.sink.done;
      await _channel.sink.close();
      isConnected = false;
    } catch (e) {
      print('Error closing WebSocket: $e');
    }
  }

  // Set callback for transcription result
  void setOnTranscriptionListener(Function(String) listener) {
    onTranscription = listener;
  }
}
