// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_capsule_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TimeCapsuleModel _$TimeCapsuleModelFromJson(Map<String, dynamic> json) {
  return _TimeCapsuleModel.fromJson(json);
}

/// @nodoc
mixin _$TimeCapsuleModel {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get openDate => throw _privateConstructorUsedError;
  DateTime? get openedAt => throw _privateConstructorUsedError;
  CapsuleStatus get status => throw _privateConstructorUsedError;
  bool get notificationSent => throw _privateConstructorUsedError;
  bool get isReadyToOpen => throw _privateConstructorUsedError;
  int get daysUntilOpen => throw _privateConstructorUsedError;

  /// Serializes this TimeCapsuleModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeCapsuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeCapsuleModelCopyWith<TimeCapsuleModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeCapsuleModelCopyWith<$Res> {
  factory $TimeCapsuleModelCopyWith(
    TimeCapsuleModel value,
    $Res Function(TimeCapsuleModel) then,
  ) = _$TimeCapsuleModelCopyWithImpl<$Res, TimeCapsuleModel>;
  @useResult
  $Res call({
    String id,
    String userId,
    String title,
    String content,
    DateTime createdAt,
    DateTime openDate,
    DateTime? openedAt,
    CapsuleStatus status,
    bool notificationSent,
    bool isReadyToOpen,
    int daysUntilOpen,
  });
}

/// @nodoc
class _$TimeCapsuleModelCopyWithImpl<$Res, $Val extends TimeCapsuleModel>
    implements $TimeCapsuleModelCopyWith<$Res> {
  _$TimeCapsuleModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeCapsuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? content = null,
    Object? createdAt = null,
    Object? openDate = null,
    Object? openedAt = freezed,
    Object? status = null,
    Object? notificationSent = null,
    Object? isReadyToOpen = null,
    Object? daysUntilOpen = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            openDate: null == openDate
                ? _value.openDate
                : openDate // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            openedAt: freezed == openedAt
                ? _value.openedAt
                : openedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as CapsuleStatus,
            notificationSent: null == notificationSent
                ? _value.notificationSent
                : notificationSent // ignore: cast_nullable_to_non_nullable
                      as bool,
            isReadyToOpen: null == isReadyToOpen
                ? _value.isReadyToOpen
                : isReadyToOpen // ignore: cast_nullable_to_non_nullable
                      as bool,
            daysUntilOpen: null == daysUntilOpen
                ? _value.daysUntilOpen
                : daysUntilOpen // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TimeCapsuleModelImplCopyWith<$Res>
    implements $TimeCapsuleModelCopyWith<$Res> {
  factory _$$TimeCapsuleModelImplCopyWith(
    _$TimeCapsuleModelImpl value,
    $Res Function(_$TimeCapsuleModelImpl) then,
  ) = __$$TimeCapsuleModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    String title,
    String content,
    DateTime createdAt,
    DateTime openDate,
    DateTime? openedAt,
    CapsuleStatus status,
    bool notificationSent,
    bool isReadyToOpen,
    int daysUntilOpen,
  });
}

/// @nodoc
class __$$TimeCapsuleModelImplCopyWithImpl<$Res>
    extends _$TimeCapsuleModelCopyWithImpl<$Res, _$TimeCapsuleModelImpl>
    implements _$$TimeCapsuleModelImplCopyWith<$Res> {
  __$$TimeCapsuleModelImplCopyWithImpl(
    _$TimeCapsuleModelImpl _value,
    $Res Function(_$TimeCapsuleModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TimeCapsuleModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? title = null,
    Object? content = null,
    Object? createdAt = null,
    Object? openDate = null,
    Object? openedAt = freezed,
    Object? status = null,
    Object? notificationSent = null,
    Object? isReadyToOpen = null,
    Object? daysUntilOpen = null,
  }) {
    return _then(
      _$TimeCapsuleModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        openDate: null == openDate
            ? _value.openDate
            : openDate // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        openedAt: freezed == openedAt
            ? _value.openedAt
            : openedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as CapsuleStatus,
        notificationSent: null == notificationSent
            ? _value.notificationSent
            : notificationSent // ignore: cast_nullable_to_non_nullable
                  as bool,
        isReadyToOpen: null == isReadyToOpen
            ? _value.isReadyToOpen
            : isReadyToOpen // ignore: cast_nullable_to_non_nullable
                  as bool,
        daysUntilOpen: null == daysUntilOpen
            ? _value.daysUntilOpen
            : daysUntilOpen // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeCapsuleModelImpl implements _TimeCapsuleModel {
  const _$TimeCapsuleModelImpl({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.openDate,
    this.openedAt,
    required this.status,
    required this.notificationSent,
    required this.isReadyToOpen,
    required this.daysUntilOpen,
  });

  factory _$TimeCapsuleModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeCapsuleModelImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String title;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final DateTime openDate;
  @override
  final DateTime? openedAt;
  @override
  final CapsuleStatus status;
  @override
  final bool notificationSent;
  @override
  final bool isReadyToOpen;
  @override
  final int daysUntilOpen;

  @override
  String toString() {
    return 'TimeCapsuleModel(id: $id, userId: $userId, title: $title, content: $content, createdAt: $createdAt, openDate: $openDate, openedAt: $openedAt, status: $status, notificationSent: $notificationSent, isReadyToOpen: $isReadyToOpen, daysUntilOpen: $daysUntilOpen)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeCapsuleModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.openDate, openDate) ||
                other.openDate == openDate) &&
            (identical(other.openedAt, openedAt) ||
                other.openedAt == openedAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.notificationSent, notificationSent) ||
                other.notificationSent == notificationSent) &&
            (identical(other.isReadyToOpen, isReadyToOpen) ||
                other.isReadyToOpen == isReadyToOpen) &&
            (identical(other.daysUntilOpen, daysUntilOpen) ||
                other.daysUntilOpen == daysUntilOpen));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    title,
    content,
    createdAt,
    openDate,
    openedAt,
    status,
    notificationSent,
    isReadyToOpen,
    daysUntilOpen,
  );

  /// Create a copy of TimeCapsuleModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeCapsuleModelImplCopyWith<_$TimeCapsuleModelImpl> get copyWith =>
      __$$TimeCapsuleModelImplCopyWithImpl<_$TimeCapsuleModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeCapsuleModelImplToJson(this);
  }
}

abstract class _TimeCapsuleModel implements TimeCapsuleModel {
  const factory _TimeCapsuleModel({
    required final String id,
    required final String userId,
    required final String title,
    required final String content,
    required final DateTime createdAt,
    required final DateTime openDate,
    final DateTime? openedAt,
    required final CapsuleStatus status,
    required final bool notificationSent,
    required final bool isReadyToOpen,
    required final int daysUntilOpen,
  }) = _$TimeCapsuleModelImpl;

  factory _TimeCapsuleModel.fromJson(Map<String, dynamic> json) =
      _$TimeCapsuleModelImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get title;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  DateTime get openDate;
  @override
  DateTime? get openedAt;
  @override
  CapsuleStatus get status;
  @override
  bool get notificationSent;
  @override
  bool get isReadyToOpen;
  @override
  int get daysUntilOpen;

  /// Create a copy of TimeCapsuleModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeCapsuleModelImplCopyWith<_$TimeCapsuleModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
