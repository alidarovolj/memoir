import 'dart:async';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:memoir/core/config/api_config.dart';
import 'package:memoir/core/config/app_config.dart';
import 'package:memoir/features/messages/data/models/message_model.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  String? _userId;
  StreamController<MessageModel>? _messageController;
  StreamController<Map<String, dynamic>>? _eventController;
  bool _isConnected = false;

  Stream<MessageModel> get messageStream => _messageController?.stream ?? const Stream.empty();
  Stream<Map<String, dynamic>> get eventStream => _eventController?.stream ?? const Stream.empty();

  Future<void> connect(String userId) async {
    if (_isConnected && _userId == userId) {
      return; // Already connected
    }

    _userId = userId;
    _messageController = StreamController<MessageModel>.broadcast();
    _eventController = StreamController<Map<String, dynamic>>.broadcast();

    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(AppConfig.accessTokenKey);
      
      if (token == null) {
        throw Exception('No auth token available');
      }
      
      // Convert http to ws
      final wsUrl = ApiConfig.baseUrl
          .replaceFirst('http://', 'ws://')
          .replaceFirst('https://', 'wss://');
      
      final url = '$wsUrl/api/v1/messages/ws/$userId?token=$token';
      
      print('🔌 [WebSocket] Connecting to: $url');
      
      _channel = WebSocketChannel.connect(Uri.parse(url));
      _isConnected = true;
      
      print('✅ [WebSocket] Connected successfully');

      _channel!.stream.listen(
        (data) {
          try {
            print('📨 [WebSocket] Received raw data: ${data.toString().substring(0, data.toString().length > 200 ? 200 : data.toString().length)}');
            final jsonData = jsonDecode(data);
            final type = jsonData['type'] as String?;
            print('📨 [WebSocket] Message type: $type');

            if (type == 'message') {
              final messageData = jsonData['message'] as Map<String, dynamic>;
              print('📨 [WebSocket] Parsing message: ${messageData['id']}');
              final message = MessageModel.fromJson(messageData);
              _messageController?.add(message);
              print('✅ [WebSocket] Message added to stream');
            } else if (type == 'connected') {
              print('✅ [WebSocket] Connection confirmed by server');
              _eventController?.add(jsonData);
            } else {
              print('📡 [WebSocket] Event received: $type');
              _eventController?.add(jsonData);
            }
          } catch (e, stackTrace) {
            print('❌ [WebSocket] Error parsing message: $e');
            print('Stack trace: $stackTrace');
          }
        },
        onError: (error) {
          print('❌ [WebSocket] Stream error: $error');
          _isConnected = false;
        },
        onDone: () {
          print('🔌 [WebSocket] Stream closed (onDone)');
          _isConnected = false;
        },
        cancelOnError: false,
      );
    } catch (e) {
      print('Error connecting WebSocket: $e');
      _isConnected = false;
      rethrow;
    }
  }

  Future<void> sendMessage(String receiverId, String content) async {
    if (!_isConnected || _channel == null) {
      print('❌ [WebSocket] Cannot send message: not connected');
      throw Exception('WebSocket not connected');
    }

    final message = {
      'type': 'send',
      'receiver_id': receiverId,
      'content': content,
    };

    print('📤 [WebSocket] Sending message: ${jsonEncode(message)}');
    try {
      _channel!.sink.add(jsonEncode(message));
      print('✅ [WebSocket] Message sent successfully');
    } catch (e) {
      print('❌ [WebSocket] Error sending message: $e');
      rethrow;
    }
  }

  Future<void> markAsRead(String messageId) async {
    if (!_isConnected || _channel == null) {
      return;
    }

    final message = {
      'type': 'read',
      'message_id': messageId,
    };

    _channel!.sink.add(jsonEncode(message));
  }

  Future<void> sendTyping(String receiverId, bool isTyping) async {
    if (!_isConnected || _channel == null) {
      return;
    }

    final message = {
      'type': 'typing',
      'receiver_id': receiverId,
      'is_typing': isTyping,
    };

    _channel!.sink.add(jsonEncode(message));
  }

  Future<void> disconnect() async {
    await _channel?.sink.close();
    await _messageController?.close();
    await _eventController?.close();
    _channel = null;
    _messageController = null;
    _eventController = null;
    _isConnected = false;
    _userId = null;
  }

  bool get isConnected => _isConnected;
}
