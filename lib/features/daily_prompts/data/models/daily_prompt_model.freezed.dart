// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_prompt_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

DailyPromptModel _$DailyPromptModelFromJson(Map<String, dynamic> json) {
  return _DailyPromptModel.fromJson(json);
}

/// @nodoc
mixin _$DailyPromptModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'prompt_text')
  String get promptText => throw _privateConstructorUsedError;
  @JsonKey(name: 'prompt_icon')
  String get promptIcon => throw _privateConstructorUsedError;
  PromptCategory get category => throw _privateConstructorUsedError;
  @JsonKey(name: 'prompt_type')
  PromptType get promptType => throw _privateConstructorUsedError;
  @JsonKey(name: 'is_active')
  bool get isActive => throw _privateConstructorUsedError;
  @JsonKey(name: 'order_index')
  int get orderIndex => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;

  /// Serializes this DailyPromptModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DailyPromptModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyPromptModelCopyWith<DailyPromptModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyPromptModelCopyWith<$Res> {
  factory $DailyPromptModelCopyWith(
    DailyPromptModel value,
    $Res Function(DailyPromptModel) then,
  ) = _$DailyPromptModelCopyWithImpl<$Res, DailyPromptModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'prompt_text') String promptText,
    @JsonKey(name: 'prompt_icon') String promptIcon,
    PromptCategory category,
    @JsonKey(name: 'prompt_type') PromptType promptType,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'order_index') int orderIndex,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class _$DailyPromptModelCopyWithImpl<$Res, $Val extends DailyPromptModel>
    implements $DailyPromptModelCopyWith<$Res> {
  _$DailyPromptModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyPromptModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? promptText = null,
    Object? promptIcon = null,
    Object? category = null,
    Object? promptType = null,
    Object? isActive = null,
    Object? orderIndex = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            promptText: null == promptText
                ? _value.promptText
                : promptText // ignore: cast_nullable_to_non_nullable
                      as String,
            promptIcon: null == promptIcon
                ? _value.promptIcon
                : promptIcon // ignore: cast_nullable_to_non_nullable
                      as String,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as PromptCategory,
            promptType: null == promptType
                ? _value.promptType
                : promptType // ignore: cast_nullable_to_non_nullable
                      as PromptType,
            isActive: null == isActive
                ? _value.isActive
                : isActive // ignore: cast_nullable_to_non_nullable
                      as bool,
            orderIndex: null == orderIndex
                ? _value.orderIndex
                : orderIndex // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DailyPromptModelImplCopyWith<$Res>
    implements $DailyPromptModelCopyWith<$Res> {
  factory _$$DailyPromptModelImplCopyWith(
    _$DailyPromptModelImpl value,
    $Res Function(_$DailyPromptModelImpl) then,
  ) = __$$DailyPromptModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'prompt_text') String promptText,
    @JsonKey(name: 'prompt_icon') String promptIcon,
    PromptCategory category,
    @JsonKey(name: 'prompt_type') PromptType promptType,
    @JsonKey(name: 'is_active') bool isActive,
    @JsonKey(name: 'order_index') int orderIndex,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
  });
}

/// @nodoc
class __$$DailyPromptModelImplCopyWithImpl<$Res>
    extends _$DailyPromptModelCopyWithImpl<$Res, _$DailyPromptModelImpl>
    implements _$$DailyPromptModelImplCopyWith<$Res> {
  __$$DailyPromptModelImplCopyWithImpl(
    _$DailyPromptModelImpl _value,
    $Res Function(_$DailyPromptModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DailyPromptModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? promptText = null,
    Object? promptIcon = null,
    Object? category = null,
    Object? promptType = null,
    Object? isActive = null,
    Object? orderIndex = null,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(
      _$DailyPromptModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        promptText: null == promptText
            ? _value.promptText
            : promptText // ignore: cast_nullable_to_non_nullable
                  as String,
        promptIcon: null == promptIcon
            ? _value.promptIcon
            : promptIcon // ignore: cast_nullable_to_non_nullable
                  as String,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as PromptCategory,
        promptType: null == promptType
            ? _value.promptType
            : promptType // ignore: cast_nullable_to_non_nullable
                  as PromptType,
        isActive: null == isActive
            ? _value.isActive
            : isActive // ignore: cast_nullable_to_non_nullable
                  as bool,
        orderIndex: null == orderIndex
            ? _value.orderIndex
            : orderIndex // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DailyPromptModelImpl implements _DailyPromptModel {
  const _$DailyPromptModelImpl({
    required this.id,
    @JsonKey(name: 'prompt_text') required this.promptText,
    @JsonKey(name: 'prompt_icon') required this.promptIcon,
    required this.category,
    @JsonKey(name: 'prompt_type') required this.promptType,
    @JsonKey(name: 'is_active') required this.isActive,
    @JsonKey(name: 'order_index') required this.orderIndex,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
  });

  factory _$DailyPromptModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DailyPromptModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'prompt_text')
  final String promptText;
  @override
  @JsonKey(name: 'prompt_icon')
  final String promptIcon;
  @override
  final PromptCategory category;
  @override
  @JsonKey(name: 'prompt_type')
  final PromptType promptType;
  @override
  @JsonKey(name: 'is_active')
  final bool isActive;
  @override
  @JsonKey(name: 'order_index')
  final int orderIndex;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;

  @override
  String toString() {
    return 'DailyPromptModel(id: $id, promptText: $promptText, promptIcon: $promptIcon, category: $category, promptType: $promptType, isActive: $isActive, orderIndex: $orderIndex, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyPromptModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.promptText, promptText) ||
                other.promptText == promptText) &&
            (identical(other.promptIcon, promptIcon) ||
                other.promptIcon == promptIcon) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.promptType, promptType) ||
                other.promptType == promptType) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.orderIndex, orderIndex) ||
                other.orderIndex == orderIndex) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    promptText,
    promptIcon,
    category,
    promptType,
    isActive,
    orderIndex,
    createdAt,
    updatedAt,
  );

  /// Create a copy of DailyPromptModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyPromptModelImplCopyWith<_$DailyPromptModelImpl> get copyWith =>
      __$$DailyPromptModelImplCopyWithImpl<_$DailyPromptModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$DailyPromptModelImplToJson(this);
  }
}

abstract class _DailyPromptModel implements DailyPromptModel {
  const factory _DailyPromptModel({
    required final String id,
    @JsonKey(name: 'prompt_text') required final String promptText,
    @JsonKey(name: 'prompt_icon') required final String promptIcon,
    required final PromptCategory category,
    @JsonKey(name: 'prompt_type') required final PromptType promptType,
    @JsonKey(name: 'is_active') required final bool isActive,
    @JsonKey(name: 'order_index') required final int orderIndex,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
  }) = _$DailyPromptModelImpl;

  factory _DailyPromptModel.fromJson(Map<String, dynamic> json) =
      _$DailyPromptModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'prompt_text')
  String get promptText;
  @override
  @JsonKey(name: 'prompt_icon')
  String get promptIcon;
  @override
  PromptCategory get category;
  @override
  @JsonKey(name: 'prompt_type')
  PromptType get promptType;
  @override
  @JsonKey(name: 'is_active')
  bool get isActive;
  @override
  @JsonKey(name: 'order_index')
  int get orderIndex;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;

  /// Create a copy of DailyPromptModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyPromptModelImplCopyWith<_$DailyPromptModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
