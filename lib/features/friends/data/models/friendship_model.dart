import 'package:freezed_annotation/freezed_annotation.dart';

part 'friendship_model.freezed.dart';
part 'friendship_model.g.dart';

enum FriendshipStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('accepted')
  accepted,
  @JsonValue('rejected')
  rejected,
  @JsonValue('blocked')
  blocked,
}

@freezed
class FriendProfile with _$FriendProfile {
  const factory FriendProfile({
    required int id,
    required String username,
    String? avatarUrl,
    required DateTime createdAt,
    @Default(0) int memoriesCount,
    @Default(0) int friendsCount,
    @Default(0) int streakDays,
  }) = _FriendProfile;

  factory FriendProfile.fromJson(Map<String, dynamic> json) =>
      _$FriendProfileFromJson(json);
}

@freezed
class FriendshipModel with _$FriendshipModel {
  const factory FriendshipModel({
    required int id,
    required int requesterId,
    required int addresseeId,
    required FriendshipStatus status,
    required DateTime createdAt,
    required DateTime updatedAt,
    FriendProfile? friend,
  }) = _FriendshipModel;

  factory FriendshipModel.fromJson(Map<String, dynamic> json) =>
      _$FriendshipModelFromJson(json);
}

@freezed
class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required int id,
    required FriendshipStatus status,
    required DateTime createdAt,
    required FriendProfile requester,
  }) = _FriendRequest;

  factory FriendRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestFromJson(json);
}
