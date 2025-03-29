import 'dart:async';
import 'dart:convert';

import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

enum WebSocketStatus { connecting, connected, disconnected, error }

class WebSocketService {
  static final WebSocketService _instance = WebSocketService._internal();
  factory WebSocketService() => _instance;
  WebSocketService._internal();

  WebSocketChannel? _channel;
  final _messageController = StreamController<Map<String, dynamic>>.broadcast();
  final _statusController = StreamController<WebSocketStatus>.broadcast();
  Timer? _reconnectTimer;
  bool _isConnecting = false;
  String? _wsUrl;

  Stream<Map<String, dynamic>> get messageStream => _messageController.stream;
  Stream<WebSocketStatus> get statusStream => _statusController.stream;

  Future<void> connect(String url) async {
    if (_isConnecting) return;
    _isConnecting = true;
    _wsUrl = url;

    try {
      _statusController.add(WebSocketStatus.connecting);
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _statusController.add(WebSocketStatus.connected);

      _channel!.stream.listen(
        (message) {
          try {
            final decodedMessage = jsonDecode(message as String);
            _messageController.add(decodedMessage as Map<String, dynamic>);
          } catch (e) {
            print('Error decoding message: $e');
          }
        },
        onError: (error) {
          print('WebSocket error: $error');
          _statusController.add(WebSocketStatus.error);
          _scheduleReconnect();
        },
        onDone: () {
          print('WebSocket connection closed');
          _statusController.add(WebSocketStatus.disconnected);
          _scheduleReconnect();
        },
      );
    } catch (e) {
      print('Error connecting to WebSocket: $e');
      _statusController.add(WebSocketStatus.error);
      _scheduleReconnect();
    } finally {
      _isConnecting = false;
    }
  }

  void sendMessage(Map<String, dynamic> message) {
    if (_channel != null) {
      try {
        final encodedMessage = jsonEncode(message);
        _channel!.sink.add(encodedMessage);
      } catch (e) {
        print('Error sending message: $e');
      }
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (_wsUrl != null) {
        connect(_wsUrl!);
      }
    });
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _channel?.sink.close(status.goingAway);
    _channel = null;
    _statusController.add(WebSocketStatus.disconnected);
  }

  void dispose() {
    disconnect();
    _messageController.close();
    _statusController.close();
  }
}
