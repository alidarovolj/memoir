import 'package:freezed_annotation/freezed_annotation.dart';

part 'memory_sharing_model.freezed.dart';
part 'memory_sharing_model.g.dart';

enum PrivacyLevel {
  @JsonValue('private')
  private,
  @JsonValue('friends_only')
  friendsOnly,
  @JsonValue('shared')
  shared,
  @JsonValue('public')
  public,
}

@freezed
class SharedWithUser with _$SharedWithUser {
  const factory SharedWithUser({
    required int userId,
    required String username,
    required bool canComment,
    required bool canReact,
    required DateTime sharedAt,
    DateTime? viewedAt,
  }) = _SharedWithUser;

  factory SharedWithUser.fromJson(Map<String, dynamic> json) =>
      _$SharedWithUserFromJson(json);
}

@freezed
class MemoryShareInfo with _$MemoryShareInfo {
  const factory MemoryShareInfo({
    required String memoryId,
    required PrivacyLevel privacyLevel,
    required List<SharedWithUser> sharedWith,
    required int totalShares,
  }) = _MemoryShareInfo;

  factory MemoryShareInfo.fromJson(Map<String, dynamic> json) =>
      _$MemoryShareInfoFromJson(json);
}

@freezed
class SharedMemoryItem with _$SharedMemoryItem {
  const SharedMemoryItem._();
  
  const factory SharedMemoryItem({
    required String memoryId,
    required String title,
    required String content,
    String? imageUrl,
    required DateTime createdAt,
    required String ownerId,
    required String ownerUsername,
    required DateTime sharedAt,
    required bool canComment,
    required bool canReact,
    DateTime? viewedAt,
  }) = _SharedMemoryItem;

  factory SharedMemoryItem.fromJson(Map<String, dynamic> json) =>
      _$SharedMemoryItemFromJson(json);
      
  bool get viewed => viewedAt != null;
}
