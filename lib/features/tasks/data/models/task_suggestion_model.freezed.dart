// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_suggestion_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

TaskSuggestionModel _$TaskSuggestionModelFromJson(Map<String, dynamic> json) {
  return _TaskSuggestionModel.fromJson(json);
}

/// @nodoc
mixin _$TaskSuggestionModel {
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_scope')
  String get timeScope => throw _privateConstructorUsedError;
  String get priority => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  String get reasoning => throw _privateConstructorUsedError;
  String? get category => throw _privateConstructorUsedError;

  /// Serializes this TaskSuggestionModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TaskSuggestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TaskSuggestionModelCopyWith<TaskSuggestionModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskSuggestionModelCopyWith<$Res> {
  factory $TaskSuggestionModelCopyWith(
    TaskSuggestionModel value,
    $Res Function(TaskSuggestionModel) then,
  ) = _$TaskSuggestionModelCopyWithImpl<$Res, TaskSuggestionModel>;
  @useResult
  $Res call({
    String title,
    String description,
    @JsonKey(name: 'time_scope') String timeScope,
    String priority,
    double confidence,
    String reasoning,
    String? category,
  });
}

/// @nodoc
class _$TaskSuggestionModelCopyWithImpl<$Res, $Val extends TaskSuggestionModel>
    implements $TaskSuggestionModelCopyWith<$Res> {
  _$TaskSuggestionModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TaskSuggestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? timeScope = null,
    Object? priority = null,
    Object? confidence = null,
    Object? reasoning = null,
    Object? category = freezed,
  }) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            timeScope: null == timeScope
                ? _value.timeScope
                : timeScope // ignore: cast_nullable_to_non_nullable
                      as String,
            priority: null == priority
                ? _value.priority
                : priority // ignore: cast_nullable_to_non_nullable
                      as String,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            reasoning: null == reasoning
                ? _value.reasoning
                : reasoning // ignore: cast_nullable_to_non_nullable
                      as String,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$TaskSuggestionModelImplCopyWith<$Res>
    implements $TaskSuggestionModelCopyWith<$Res> {
  factory _$$TaskSuggestionModelImplCopyWith(
    _$TaskSuggestionModelImpl value,
    $Res Function(_$TaskSuggestionModelImpl) then,
  ) = __$$TaskSuggestionModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String title,
    String description,
    @JsonKey(name: 'time_scope') String timeScope,
    String priority,
    double confidence,
    String reasoning,
    String? category,
  });
}

/// @nodoc
class __$$TaskSuggestionModelImplCopyWithImpl<$Res>
    extends _$TaskSuggestionModelCopyWithImpl<$Res, _$TaskSuggestionModelImpl>
    implements _$$TaskSuggestionModelImplCopyWith<$Res> {
  __$$TaskSuggestionModelImplCopyWithImpl(
    _$TaskSuggestionModelImpl _value,
    $Res Function(_$TaskSuggestionModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of TaskSuggestionModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? description = null,
    Object? timeScope = null,
    Object? priority = null,
    Object? confidence = null,
    Object? reasoning = null,
    Object? category = freezed,
  }) {
    return _then(
      _$TaskSuggestionModelImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        timeScope: null == timeScope
            ? _value.timeScope
            : timeScope // ignore: cast_nullable_to_non_nullable
                  as String,
        priority: null == priority
            ? _value.priority
            : priority // ignore: cast_nullable_to_non_nullable
                  as String,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        reasoning: null == reasoning
            ? _value.reasoning
            : reasoning // ignore: cast_nullable_to_non_nullable
                  as String,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$TaskSuggestionModelImpl implements _TaskSuggestionModel {
  const _$TaskSuggestionModelImpl({
    required this.title,
    required this.description,
    @JsonKey(name: 'time_scope') required this.timeScope,
    required this.priority,
    required this.confidence,
    required this.reasoning,
    this.category,
  });

  factory _$TaskSuggestionModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$TaskSuggestionModelImplFromJson(json);

  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'time_scope')
  final String timeScope;
  @override
  final String priority;
  @override
  final double confidence;
  @override
  final String reasoning;
  @override
  final String? category;

  @override
  String toString() {
    return 'TaskSuggestionModel(title: $title, description: $description, timeScope: $timeScope, priority: $priority, confidence: $confidence, reasoning: $reasoning, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TaskSuggestionModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.timeScope, timeScope) ||
                other.timeScope == timeScope) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            (identical(other.reasoning, reasoning) ||
                other.reasoning == reasoning) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    title,
    description,
    timeScope,
    priority,
    confidence,
    reasoning,
    category,
  );

  /// Create a copy of TaskSuggestionModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TaskSuggestionModelImplCopyWith<_$TaskSuggestionModelImpl> get copyWith =>
      __$$TaskSuggestionModelImplCopyWithImpl<_$TaskSuggestionModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$TaskSuggestionModelImplToJson(this);
  }
}

abstract class _TaskSuggestionModel implements TaskSuggestionModel {
  const factory _TaskSuggestionModel({
    required final String title,
    required final String description,
    @JsonKey(name: 'time_scope') required final String timeScope,
    required final String priority,
    required final double confidence,
    required final String reasoning,
    final String? category,
  }) = _$TaskSuggestionModelImpl;

  factory _TaskSuggestionModel.fromJson(Map<String, dynamic> json) =
      _$TaskSuggestionModelImpl.fromJson;

  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'time_scope')
  String get timeScope;
  @override
  String get priority;
  @override
  double get confidence;
  @override
  String get reasoning;
  @override
  String? get category;

  /// Create a copy of TaskSuggestionModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TaskSuggestionModelImplCopyWith<_$TaskSuggestionModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
