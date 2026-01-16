import 'package:dio/dio.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/friends/data/models/friendship_model.dart';

class FriendsRemoteDataSource {
  final Dio _dio;

  FriendsRemoteDataSource(DioClient dioClient) : _dio = DioClient.instance;

  /// Get list of friends
  Future<List<FriendProfile>> getFriends() async {
    try {
      final response = await _dio.get('/api/v1/friends/');
      final data = response.data as Map<String, dynamic>;
      final friendsList = data['friends'] as List;
      return friendsList
          .map((json) => FriendProfile.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load friends: $e');
    }
  }

  /// Get pending friend requests (received)
  Future<List<FriendRequest>> getFriendRequests() async {
    try {
      final response = await _dio.get('/api/v1/friends/requests');
      final data = response.data as Map<String, dynamic>;
      final requestsList = data['requests'] as List;
      return requestsList
          .map((json) => FriendRequest.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load friend requests: $e');
    }
  }

  /// Send friend request
  Future<Map<String, dynamic>> sendFriendRequest(String addresseeId) async {
    try {
      final response = await _dio.post(
        '/api/v1/friends/requests',
        data: {'addressee_id': addresseeId},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to send friend request: $e');
    }
  }

  /// Respond to friend request (accept/reject)
  Future<Map<String, dynamic>> respondToFriendRequest({
    required String requestId,
    required String action, // 'accept' or 'reject'
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/friends/requests/respond',
        data: {'request_id': requestId, 'action': action},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to respond to friend request: $e');
    }
  }

  /// Remove friend
  Future<Map<String, dynamic>> removeFriend(String friendId) async {
    try {
      final response = await _dio.delete(
        '/api/v1/friends/remove',
        data: {'friend_id': friendId},
      );
      return response.data as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to remove friend: $e');
    }
  }

  /// Search users
  Future<List<FriendProfile>> searchUsers({
    required String query,
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final response = await _dio.post(
        '/api/v1/friends/search',
        data: {'query': query, 'limit': limit, 'offset': offset},
      );
      final data = response.data as Map<String, dynamic>;
      final usersList = data['users'] as List;
      return usersList
          .map((json) => FriendProfile.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to search users: $e');
    }
  }

  /// Get suggested users (recommendations)
  Future<List<FriendProfile>> getSuggestedUsers({int limit = 10}) async {
    try {
      final response = await _dio.get(
        '/api/v1/friends/suggestions',
        queryParameters: {'limit': limit},
      );
      final data = response.data as Map<String, dynamic>;
      final usersList = data['suggestions'] as List;
      return usersList
          .map((json) => FriendProfile.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to load suggested users: $e');
    }
  }
}
