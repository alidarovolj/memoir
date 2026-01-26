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
  const FriendProfile._();
  
  const factory FriendProfile({
    required String id,
    required String username,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'memories_count') @Default(0) int memoriesCount,
    @JsonKey(name: 'friends_count') @Default(0) int friendsCount,
    @JsonKey(name: 'streak_days') @Default(0) int streakDays,
    // Personal data
    String? profession,
    @JsonKey(name: 'telegram_url') String? telegramUrl,
    @JsonKey(name: 'whatsapp_url') String? whatsappUrl,
    @JsonKey(name: 'youtube_url') String? youtubeUrl,
    @JsonKey(name: 'linkedin_url') String? linkedinUrl,
    @JsonKey(name: 'about_me') String? aboutMe,
    String? city,
    @JsonKey(name: 'date_of_birth') DateTime? dateOfBirth,
    String? education,
    String? hobbies,
  }) = _FriendProfile;

  String get fullName {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    } else if (firstName != null) {
      return firstName!;
    } else if (lastName != null) {
      return lastName!;
    }
    return username;
  }

  factory FriendProfile.fromJson(Map<String, dynamic> json) =>
      _$FriendProfileFromJson(json);
}

@freezed
class FriendshipModel with _$FriendshipModel {
  const factory FriendshipModel({
    required String id,
    @JsonKey(name: 'requester_id') required String requesterId,
    @JsonKey(name: 'addressee_id') required String addresseeId,
    required FriendshipStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'updated_at') required DateTime updatedAt,
    FriendProfile? friend,
  }) = _FriendshipModel;

  factory FriendshipModel.fromJson(Map<String, dynamic> json) =>
      _$FriendshipModelFromJson(json);
}

@freezed
class FriendRequest with _$FriendRequest {
  const factory FriendRequest({
    required String id,
    required FriendshipStatus status,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    required FriendProfile requester,
  }) = _FriendRequest;

  factory FriendRequest.fromJson(Map<String, dynamic> json) =>
      _$FriendRequestFromJson(json);
}
