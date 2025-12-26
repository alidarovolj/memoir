import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_capsule_model.freezed.dart';
part 'time_capsule_model.g.dart';

/// Status of time capsule
enum CapsuleStatus {
  @JsonValue('SEALED')
  sealed,
  @JsonValue('OPENED')
  opened,
  @JsonValue('EXPIRED')
  expired,
}

/// Time Capsule Model - письмо будущему себе
@freezed
class TimeCapsuleModel with _$TimeCapsuleModel {
  const factory TimeCapsuleModel({
    required String id,
    required String userId,
    required String title,
    required String content,
    required DateTime createdAt,
    required DateTime openDate,
    DateTime? openedAt,
    required CapsuleStatus status,
    required bool notificationSent,
    required bool isReadyToOpen,
    required int daysUntilOpen,
  }) = _TimeCapsuleModel;

  factory TimeCapsuleModel.fromJson(Map<String, dynamic> json) =>
      _$TimeCapsuleModelFromJson(json);
}

/// Extension for TimeCapsuleModel
extension TimeCapsuleModelX on TimeCapsuleModel {
  /// Get status text in Russian
  String get statusText {
    switch (status) {
      case CapsuleStatus.sealed:
        return daysUntilOpen > 0
            ? 'Откроется через $daysUntilOpen ${_getDaysText(daysUntilOpen)}'
            : 'Готова к открытию!';
      case CapsuleStatus.opened:
        return 'Открыта';
      case CapsuleStatus.expired:
        return 'Истекла';
    }
  }

  /// Get status icon
  String get statusIcon {
    switch (status) {
      case CapsuleStatus.sealed:
        return isReadyToOpen ? '🎁' : '🔒';
      case CapsuleStatus.opened:
        return '📖';
      case CapsuleStatus.expired:
        return '⏰';
    }
  }

  /// Get status color
  String get statusColor {
    switch (status) {
      case CapsuleStatus.sealed:
        return isReadyToOpen ? '#34D399' : '#F59E0B';
      case CapsuleStatus.opened:
        return '#277070';
      case CapsuleStatus.expired:
        return '#EF4444';
    }
  }

  String _getDaysText(int days) {
    if (days % 10 == 1 && days % 100 != 11) return 'день';
    if ([2, 3, 4].contains(days % 10) && ![12, 13, 14].contains(days % 100)) {
      return 'дня';
    }
    return 'дней';
  }
}
