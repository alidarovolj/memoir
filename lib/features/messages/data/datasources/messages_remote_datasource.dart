import 'package:dio/dio.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/messages/data/models/message_model.dart';

class MessagesRemoteDataSource {
  final Dio _dio;

  MessagesRemoteDataSource(DioClient dioClient) : _dio = DioClient.instance;

  /// Get message history with a friend
  Future<MessageListResponse> getMessages(String friendId, {int page = 1, int pageSize = 50}) async {
    try {
      final response = await _dio.get(
        '/api/v1/messages/$friendId',
        queryParameters: {
          'page': page,
          'page_size': pageSize,
        },
      );
      return MessageListResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load messages: $e');
    }
  }

  /// Send a message via REST API (fallback when WebSocket is not available)
  Future<MessageModel> sendMessage(String receiverId, String content) async {
    try {
      final response = await _dio.post(
        '/api/v1/messages/send',
        data: {
          'receiver_id': receiverId,
          'content': content,
        },
      );
      return MessageModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  /// Mark message as read
  Future<void> markAsRead(String messageId) async {
    try {
      await _dio.post('/api/v1/messages/read/$messageId');
    } catch (e) {
      throw Exception('Failed to mark message as read: $e');
    }
  }
}
