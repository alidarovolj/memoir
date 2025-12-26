// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story_share_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoryShareModel _$StoryShareModelFromJson(Map<String, dynamic> json) {
  return _StoryShareModel.fromJson(json);
}

/// @nodoc
mixin _$StoryShareModel {
  String get id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String get story_id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String get sender_id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  String get recipient_id =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  DateTime get created_at =>
      throw _privateConstructorUsedError; // ignore: non_constant_identifier_names
  DateTime? get viewed_at => throw _privateConstructorUsedError;
  StoryUserModel? get sender => throw _privateConstructorUsedError;
  StoryUserModel? get recipient => throw _privateConstructorUsedError;
  StoryShareStoryModel? get story => throw _privateConstructorUsedError;

  /// Serializes this StoryShareModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryShareModelCopyWith<StoryShareModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryShareModelCopyWith<$Res> {
  factory $StoryShareModelCopyWith(
    StoryShareModel value,
    $Res Function(StoryShareModel) then,
  ) = _$StoryShareModelCopyWithImpl<$Res, StoryShareModel>;
  @useResult
  $Res call({
    String id,
    String story_id,
    String sender_id,
    String recipient_id,
    DateTime created_at,
    DateTime? viewed_at,
    StoryUserModel? sender,
    StoryUserModel? recipient,
    StoryShareStoryModel? story,
  });

  $StoryUserModelCopyWith<$Res>? get sender;
  $StoryUserModelCopyWith<$Res>? get recipient;
  $StoryShareStoryModelCopyWith<$Res>? get story;
}

/// @nodoc
class _$StoryShareModelCopyWithImpl<$Res, $Val extends StoryShareModel>
    implements $StoryShareModelCopyWith<$Res> {
  _$StoryShareModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? story_id = null,
    Object? sender_id = null,
    Object? recipient_id = null,
    Object? created_at = null,
    Object? viewed_at = freezed,
    Object? sender = freezed,
    Object? recipient = freezed,
    Object? story = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            story_id: null == story_id
                ? _value.story_id
                : story_id // ignore: cast_nullable_to_non_nullable
                      as String,
            sender_id: null == sender_id
                ? _value.sender_id
                : sender_id // ignore: cast_nullable_to_non_nullable
                      as String,
            recipient_id: null == recipient_id
                ? _value.recipient_id
                : recipient_id // ignore: cast_nullable_to_non_nullable
                      as String,
            created_at: null == created_at
                ? _value.created_at
                : created_at // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            viewed_at: freezed == viewed_at
                ? _value.viewed_at
                : viewed_at // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            sender: freezed == sender
                ? _value.sender
                : sender // ignore: cast_nullable_to_non_nullable
                      as StoryUserModel?,
            recipient: freezed == recipient
                ? _value.recipient
                : recipient // ignore: cast_nullable_to_non_nullable
                      as StoryUserModel?,
            story: freezed == story
                ? _value.story
                : story // ignore: cast_nullable_to_non_nullable
                      as StoryShareStoryModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of StoryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryUserModelCopyWith<$Res>? get sender {
    if (_value.sender == null) {
      return null;
    }

    return $StoryUserModelCopyWith<$Res>(_value.sender!, (value) {
      return _then(_value.copyWith(sender: value) as $Val);
    });
  }

  /// Create a copy of StoryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryUserModelCopyWith<$Res>? get recipient {
    if (_value.recipient == null) {
      return null;
    }

    return $StoryUserModelCopyWith<$Res>(_value.recipient!, (value) {
      return _then(_value.copyWith(recipient: value) as $Val);
    });
  }

  /// Create a copy of StoryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryShareStoryModelCopyWith<$Res>? get story {
    if (_value.story == null) {
      return null;
    }

    return $StoryShareStoryModelCopyWith<$Res>(_value.story!, (value) {
      return _then(_value.copyWith(story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoryShareModelImplCopyWith<$Res>
    implements $StoryShareModelCopyWith<$Res> {
  factory _$$StoryShareModelImplCopyWith(
    _$StoryShareModelImpl value,
    $Res Function(_$StoryShareModelImpl) then,
  ) = __$$StoryShareModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String story_id,
    String sender_id,
    String recipient_id,
    DateTime created_at,
    DateTime? viewed_at,
    StoryUserModel? sender,
    StoryUserModel? recipient,
    StoryShareStoryModel? story,
  });

  @override
  $StoryUserModelCopyWith<$Res>? get sender;
  @override
  $StoryUserModelCopyWith<$Res>? get recipient;
  @override
  $StoryShareStoryModelCopyWith<$Res>? get story;
}

/// @nodoc
class __$$StoryShareModelImplCopyWithImpl<$Res>
    extends _$StoryShareModelCopyWithImpl<$Res, _$StoryShareModelImpl>
    implements _$$StoryShareModelImplCopyWith<$Res> {
  __$$StoryShareModelImplCopyWithImpl(
    _$StoryShareModelImpl _value,
    $Res Function(_$StoryShareModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? story_id = null,
    Object? sender_id = null,
    Object? recipient_id = null,
    Object? created_at = null,
    Object? viewed_at = freezed,
    Object? sender = freezed,
    Object? recipient = freezed,
    Object? story = freezed,
  }) {
    return _then(
      _$StoryShareModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        story_id: null == story_id
            ? _value.story_id
            : story_id // ignore: cast_nullable_to_non_nullable
                  as String,
        sender_id: null == sender_id
            ? _value.sender_id
            : sender_id // ignore: cast_nullable_to_non_nullable
                  as String,
        recipient_id: null == recipient_id
            ? _value.recipient_id
            : recipient_id // ignore: cast_nullable_to_non_nullable
                  as String,
        created_at: null == created_at
            ? _value.created_at
            : created_at // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        viewed_at: freezed == viewed_at
            ? _value.viewed_at
            : viewed_at // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        sender: freezed == sender
            ? _value.sender
            : sender // ignore: cast_nullable_to_non_nullable
                  as StoryUserModel?,
        recipient: freezed == recipient
            ? _value.recipient
            : recipient // ignore: cast_nullable_to_non_nullable
                  as StoryUserModel?,
        story: freezed == story
            ? _value.story
            : story // ignore: cast_nullable_to_non_nullable
                  as StoryShareStoryModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryShareModelImpl implements _StoryShareModel {
  const _$StoryShareModelImpl({
    required this.id,
    required this.story_id,
    required this.sender_id,
    required this.recipient_id,
    required this.created_at,
    this.viewed_at,
    this.sender,
    this.recipient,
    this.story,
  });

  factory _$StoryShareModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryShareModelImplFromJson(json);

  @override
  final String id;
  // ignore: non_constant_identifier_names
  @override
  final String story_id;
  // ignore: non_constant_identifier_names
  @override
  final String sender_id;
  // ignore: non_constant_identifier_names
  @override
  final String recipient_id;
  // ignore: non_constant_identifier_names
  @override
  final DateTime created_at;
  // ignore: non_constant_identifier_names
  @override
  final DateTime? viewed_at;
  @override
  final StoryUserModel? sender;
  @override
  final StoryUserModel? recipient;
  @override
  final StoryShareStoryModel? story;

  @override
  String toString() {
    return 'StoryShareModel(id: $id, story_id: $story_id, sender_id: $sender_id, recipient_id: $recipient_id, created_at: $created_at, viewed_at: $viewed_at, sender: $sender, recipient: $recipient, story: $story)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryShareModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.story_id, story_id) ||
                other.story_id == story_id) &&
            (identical(other.sender_id, sender_id) ||
                other.sender_id == sender_id) &&
            (identical(other.recipient_id, recipient_id) ||
                other.recipient_id == recipient_id) &&
            (identical(other.created_at, created_at) ||
                other.created_at == created_at) &&
            (identical(other.viewed_at, viewed_at) ||
                other.viewed_at == viewed_at) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.recipient, recipient) ||
                other.recipient == recipient) &&
            (identical(other.story, story) || other.story == story));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    story_id,
    sender_id,
    recipient_id,
    created_at,
    viewed_at,
    sender,
    recipient,
    story,
  );

  /// Create a copy of StoryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryShareModelImplCopyWith<_$StoryShareModelImpl> get copyWith =>
      __$$StoryShareModelImplCopyWithImpl<_$StoryShareModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryShareModelImplToJson(this);
  }
}

abstract class _StoryShareModel implements StoryShareModel {
  const factory _StoryShareModel({
    required final String id,
    required final String story_id,
    required final String sender_id,
    required final String recipient_id,
    required final DateTime created_at,
    final DateTime? viewed_at,
    final StoryUserModel? sender,
    final StoryUserModel? recipient,
    final StoryShareStoryModel? story,
  }) = _$StoryShareModelImpl;

  factory _StoryShareModel.fromJson(Map<String, dynamic> json) =
      _$StoryShareModelImpl.fromJson;

  @override
  String get id; // ignore: non_constant_identifier_names
  @override
  String get story_id; // ignore: non_constant_identifier_names
  @override
  String get sender_id; // ignore: non_constant_identifier_names
  @override
  String get recipient_id; // ignore: non_constant_identifier_names
  @override
  DateTime get created_at; // ignore: non_constant_identifier_names
  @override
  DateTime? get viewed_at;
  @override
  StoryUserModel? get sender;
  @override
  StoryUserModel? get recipient;
  @override
  StoryShareStoryModel? get story;

  /// Create a copy of StoryShareModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryShareModelImplCopyWith<_$StoryShareModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryShareStoryModel _$StoryShareStoryModelFromJson(Map<String, dynamic> json) {
  return _StoryShareStoryModel.fromJson(json);
}

/// @nodoc
mixin _$StoryShareStoryModel {
  String get id => throw _privateConstructorUsedError;
  StoryUserModel? get user => throw _privateConstructorUsedError;
  StoryMemoryModel? get memory => throw _privateConstructorUsedError;

  /// Serializes this StoryShareStoryModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryShareStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryShareStoryModelCopyWith<StoryShareStoryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryShareStoryModelCopyWith<$Res> {
  factory $StoryShareStoryModelCopyWith(
    StoryShareStoryModel value,
    $Res Function(StoryShareStoryModel) then,
  ) = _$StoryShareStoryModelCopyWithImpl<$Res, StoryShareStoryModel>;
  @useResult
  $Res call({String id, StoryUserModel? user, StoryMemoryModel? memory});

  $StoryUserModelCopyWith<$Res>? get user;
  $StoryMemoryModelCopyWith<$Res>? get memory;
}

/// @nodoc
class _$StoryShareStoryModelCopyWithImpl<
  $Res,
  $Val extends StoryShareStoryModel
>
    implements $StoryShareStoryModelCopyWith<$Res> {
  _$StoryShareStoryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryShareStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = freezed,
    Object? memory = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            user: freezed == user
                ? _value.user
                : user // ignore: cast_nullable_to_non_nullable
                      as StoryUserModel?,
            memory: freezed == memory
                ? _value.memory
                : memory // ignore: cast_nullable_to_non_nullable
                      as StoryMemoryModel?,
          )
          as $Val,
    );
  }

  /// Create a copy of StoryShareStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryUserModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $StoryUserModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  /// Create a copy of StoryShareStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryMemoryModelCopyWith<$Res>? get memory {
    if (_value.memory == null) {
      return null;
    }

    return $StoryMemoryModelCopyWith<$Res>(_value.memory!, (value) {
      return _then(_value.copyWith(memory: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoryShareStoryModelImplCopyWith<$Res>
    implements $StoryShareStoryModelCopyWith<$Res> {
  factory _$$StoryShareStoryModelImplCopyWith(
    _$StoryShareStoryModelImpl value,
    $Res Function(_$StoryShareStoryModelImpl) then,
  ) = __$$StoryShareStoryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, StoryUserModel? user, StoryMemoryModel? memory});

  @override
  $StoryUserModelCopyWith<$Res>? get user;
  @override
  $StoryMemoryModelCopyWith<$Res>? get memory;
}

/// @nodoc
class __$$StoryShareStoryModelImplCopyWithImpl<$Res>
    extends _$StoryShareStoryModelCopyWithImpl<$Res, _$StoryShareStoryModelImpl>
    implements _$$StoryShareStoryModelImplCopyWith<$Res> {
  __$$StoryShareStoryModelImplCopyWithImpl(
    _$StoryShareStoryModelImpl _value,
    $Res Function(_$StoryShareStoryModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryShareStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? user = freezed,
    Object? memory = freezed,
  }) {
    return _then(
      _$StoryShareStoryModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        user: freezed == user
            ? _value.user
            : user // ignore: cast_nullable_to_non_nullable
                  as StoryUserModel?,
        memory: freezed == memory
            ? _value.memory
            : memory // ignore: cast_nullable_to_non_nullable
                  as StoryMemoryModel?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryShareStoryModelImpl implements _StoryShareStoryModel {
  const _$StoryShareStoryModelImpl({required this.id, this.user, this.memory});

  factory _$StoryShareStoryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryShareStoryModelImplFromJson(json);

  @override
  final String id;
  @override
  final StoryUserModel? user;
  @override
  final StoryMemoryModel? memory;

  @override
  String toString() {
    return 'StoryShareStoryModel(id: $id, user: $user, memory: $memory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryShareStoryModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.memory, memory) || other.memory == memory));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, user, memory);

  /// Create a copy of StoryShareStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryShareStoryModelImplCopyWith<_$StoryShareStoryModelImpl>
  get copyWith =>
      __$$StoryShareStoryModelImplCopyWithImpl<_$StoryShareStoryModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryShareStoryModelImplToJson(this);
  }
}

abstract class _StoryShareStoryModel implements StoryShareStoryModel {
  const factory _StoryShareStoryModel({
    required final String id,
    final StoryUserModel? user,
    final StoryMemoryModel? memory,
  }) = _$StoryShareStoryModelImpl;

  factory _StoryShareStoryModel.fromJson(Map<String, dynamic> json) =
      _$StoryShareStoryModelImpl.fromJson;

  @override
  String get id;
  @override
  StoryUserModel? get user;
  @override
  StoryMemoryModel? get memory;

  /// Create a copy of StoryShareStoryModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryShareStoryModelImplCopyWith<_$StoryShareStoryModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StoryShareListModel _$StoryShareListModelFromJson(Map<String, dynamic> json) {
  return _StoryShareListModel.fromJson(json);
}

/// @nodoc
mixin _$StoryShareListModel {
  List<StoryShareModel> get items => throw _privateConstructorUsedError;
  int get total => throw _privateConstructorUsedError;

  /// Serializes this StoryShareListModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryShareListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryShareListModelCopyWith<StoryShareListModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryShareListModelCopyWith<$Res> {
  factory $StoryShareListModelCopyWith(
    StoryShareListModel value,
    $Res Function(StoryShareListModel) then,
  ) = _$StoryShareListModelCopyWithImpl<$Res, StoryShareListModel>;
  @useResult
  $Res call({List<StoryShareModel> items, int total});
}

/// @nodoc
class _$StoryShareListModelCopyWithImpl<$Res, $Val extends StoryShareListModel>
    implements $StoryShareListModelCopyWith<$Res> {
  _$StoryShareListModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryShareListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? total = null}) {
    return _then(
      _value.copyWith(
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<StoryShareModel>,
            total: null == total
                ? _value.total
                : total // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryShareListModelImplCopyWith<$Res>
    implements $StoryShareListModelCopyWith<$Res> {
  factory _$$StoryShareListModelImplCopyWith(
    _$StoryShareListModelImpl value,
    $Res Function(_$StoryShareListModelImpl) then,
  ) = __$$StoryShareListModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<StoryShareModel> items, int total});
}

/// @nodoc
class __$$StoryShareListModelImplCopyWithImpl<$Res>
    extends _$StoryShareListModelCopyWithImpl<$Res, _$StoryShareListModelImpl>
    implements _$$StoryShareListModelImplCopyWith<$Res> {
  __$$StoryShareListModelImplCopyWithImpl(
    _$StoryShareListModelImpl _value,
    $Res Function(_$StoryShareListModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryShareListModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = null, Object? total = null}) {
    return _then(
      _$StoryShareListModelImpl(
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<StoryShareModel>,
        total: null == total
            ? _value.total
            : total // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryShareListModelImpl implements _StoryShareListModel {
  const _$StoryShareListModelImpl({
    required final List<StoryShareModel> items,
    required this.total,
  }) : _items = items;

  factory _$StoryShareListModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryShareListModelImplFromJson(json);

  final List<StoryShareModel> _items;
  @override
  List<StoryShareModel> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  final int total;

  @override
  String toString() {
    return 'StoryShareListModel(items: $items, total: $total)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryShareListModelImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.total, total) || other.total == total));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    total,
  );

  /// Create a copy of StoryShareListModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryShareListModelImplCopyWith<_$StoryShareListModelImpl> get copyWith =>
      __$$StoryShareListModelImplCopyWithImpl<_$StoryShareListModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryShareListModelImplToJson(this);
  }
}

abstract class _StoryShareListModel implements StoryShareListModel {
  const factory _StoryShareListModel({
    required final List<StoryShareModel> items,
    required final int total,
  }) = _$StoryShareListModelImpl;

  factory _StoryShareListModel.fromJson(Map<String, dynamic> json) =
      _$StoryShareListModelImpl.fromJson;

  @override
  List<StoryShareModel> get items;
  @override
  int get total;

  /// Create a copy of StoryShareListModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryShareListModelImplCopyWith<_$StoryShareListModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
