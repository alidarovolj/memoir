// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_story_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

StoryGenerationRequest _$StoryGenerationRequestFromJson(
  Map<String, dynamic> json,
) {
  return _StoryGenerationRequest.fromJson(json);
}

/// @nodoc
mixin _$StoryGenerationRequest {
  @JsonKey(name: 'story_type')
  StoryType get storyType => throw _privateConstructorUsedError;
  @JsonKey(name: 'memory_id')
  String? get memoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'custom_prompt')
  String? get customPrompt => throw _privateConstructorUsedError;

  /// Serializes this StoryGenerationRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryGenerationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryGenerationRequestCopyWith<StoryGenerationRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryGenerationRequestCopyWith<$Res> {
  factory $StoryGenerationRequestCopyWith(
    StoryGenerationRequest value,
    $Res Function(StoryGenerationRequest) then,
  ) = _$StoryGenerationRequestCopyWithImpl<$Res, StoryGenerationRequest>;
  @useResult
  $Res call({
    @JsonKey(name: 'story_type') StoryType storyType,
    @JsonKey(name: 'memory_id') String? memoryId,
    @JsonKey(name: 'custom_prompt') String? customPrompt,
  });
}

/// @nodoc
class _$StoryGenerationRequestCopyWithImpl<
  $Res,
  $Val extends StoryGenerationRequest
>
    implements $StoryGenerationRequestCopyWith<$Res> {
  _$StoryGenerationRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryGenerationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyType = null,
    Object? memoryId = freezed,
    Object? customPrompt = freezed,
  }) {
    return _then(
      _value.copyWith(
            storyType: null == storyType
                ? _value.storyType
                : storyType // ignore: cast_nullable_to_non_nullable
                      as StoryType,
            memoryId: freezed == memoryId
                ? _value.memoryId
                : memoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            customPrompt: freezed == customPrompt
                ? _value.customPrompt
                : customPrompt // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryGenerationRequestImplCopyWith<$Res>
    implements $StoryGenerationRequestCopyWith<$Res> {
  factory _$$StoryGenerationRequestImplCopyWith(
    _$StoryGenerationRequestImpl value,
    $Res Function(_$StoryGenerationRequestImpl) then,
  ) = __$$StoryGenerationRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'story_type') StoryType storyType,
    @JsonKey(name: 'memory_id') String? memoryId,
    @JsonKey(name: 'custom_prompt') String? customPrompt,
  });
}

/// @nodoc
class __$$StoryGenerationRequestImplCopyWithImpl<$Res>
    extends
        _$StoryGenerationRequestCopyWithImpl<$Res, _$StoryGenerationRequestImpl>
    implements _$$StoryGenerationRequestImplCopyWith<$Res> {
  __$$StoryGenerationRequestImplCopyWithImpl(
    _$StoryGenerationRequestImpl _value,
    $Res Function(_$StoryGenerationRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryGenerationRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyType = null,
    Object? memoryId = freezed,
    Object? customPrompt = freezed,
  }) {
    return _then(
      _$StoryGenerationRequestImpl(
        storyType: null == storyType
            ? _value.storyType
            : storyType // ignore: cast_nullable_to_non_nullable
                  as StoryType,
        memoryId: freezed == memoryId
            ? _value.memoryId
            : memoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        customPrompt: freezed == customPrompt
            ? _value.customPrompt
            : customPrompt // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryGenerationRequestImpl
    with DiagnosticableTreeMixin
    implements _StoryGenerationRequest {
  const _$StoryGenerationRequestImpl({
    @JsonKey(name: 'story_type') required this.storyType,
    @JsonKey(name: 'memory_id') this.memoryId,
    @JsonKey(name: 'custom_prompt') this.customPrompt,
  });

  factory _$StoryGenerationRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryGenerationRequestImplFromJson(json);

  @override
  @JsonKey(name: 'story_type')
  final StoryType storyType;
  @override
  @JsonKey(name: 'memory_id')
  final String? memoryId;
  @override
  @JsonKey(name: 'custom_prompt')
  final String? customPrompt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StoryGenerationRequest(storyType: $storyType, memoryId: $memoryId, customPrompt: $customPrompt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StoryGenerationRequest'))
      ..add(DiagnosticsProperty('storyType', storyType))
      ..add(DiagnosticsProperty('memoryId', memoryId))
      ..add(DiagnosticsProperty('customPrompt', customPrompt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryGenerationRequestImpl &&
            (identical(other.storyType, storyType) ||
                other.storyType == storyType) &&
            (identical(other.memoryId, memoryId) ||
                other.memoryId == memoryId) &&
            (identical(other.customPrompt, customPrompt) ||
                other.customPrompt == customPrompt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, storyType, memoryId, customPrompt);

  /// Create a copy of StoryGenerationRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryGenerationRequestImplCopyWith<_$StoryGenerationRequestImpl>
  get copyWith =>
      __$$StoryGenerationRequestImplCopyWithImpl<_$StoryGenerationRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryGenerationRequestImplToJson(this);
  }
}

abstract class _StoryGenerationRequest implements StoryGenerationRequest {
  const factory _StoryGenerationRequest({
    @JsonKey(name: 'story_type') required final StoryType storyType,
    @JsonKey(name: 'memory_id') final String? memoryId,
    @JsonKey(name: 'custom_prompt') final String? customPrompt,
  }) = _$StoryGenerationRequestImpl;

  factory _StoryGenerationRequest.fromJson(Map<String, dynamic> json) =
      _$StoryGenerationRequestImpl.fromJson;

  @override
  @JsonKey(name: 'story_type')
  StoryType get storyType;
  @override
  @JsonKey(name: 'memory_id')
  String? get memoryId;
  @override
  @JsonKey(name: 'custom_prompt')
  String? get customPrompt;

  /// Create a copy of StoryGenerationRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryGenerationRequestImplCopyWith<_$StoryGenerationRequestImpl>
  get copyWith => throw _privateConstructorUsedError;
}

StoryGenerationResponse _$StoryGenerationResponseFromJson(
  Map<String, dynamic> json,
) {
  return _StoryGenerationResponse.fromJson(json);
}

/// @nodoc
mixin _$StoryGenerationResponse {
  @JsonKey(name: 'story_type')
  String get storyType => throw _privateConstructorUsedError;
  @JsonKey(name: 'generated_text')
  String get generatedText => throw _privateConstructorUsedError;
  @JsonKey(name: 'source_memory_id')
  String? get sourceMemoryId => throw _privateConstructorUsedError;
  @JsonKey(name: 'tokens_used')
  int get tokensUsed => throw _privateConstructorUsedError;

  /// Serializes this StoryGenerationResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryGenerationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryGenerationResponseCopyWith<StoryGenerationResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryGenerationResponseCopyWith<$Res> {
  factory $StoryGenerationResponseCopyWith(
    StoryGenerationResponse value,
    $Res Function(StoryGenerationResponse) then,
  ) = _$StoryGenerationResponseCopyWithImpl<$Res, StoryGenerationResponse>;
  @useResult
  $Res call({
    @JsonKey(name: 'story_type') String storyType,
    @JsonKey(name: 'generated_text') String generatedText,
    @JsonKey(name: 'source_memory_id') String? sourceMemoryId,
    @JsonKey(name: 'tokens_used') int tokensUsed,
  });
}

/// @nodoc
class _$StoryGenerationResponseCopyWithImpl<
  $Res,
  $Val extends StoryGenerationResponse
>
    implements $StoryGenerationResponseCopyWith<$Res> {
  _$StoryGenerationResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryGenerationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyType = null,
    Object? generatedText = null,
    Object? sourceMemoryId = freezed,
    Object? tokensUsed = null,
  }) {
    return _then(
      _value.copyWith(
            storyType: null == storyType
                ? _value.storyType
                : storyType // ignore: cast_nullable_to_non_nullable
                      as String,
            generatedText: null == generatedText
                ? _value.generatedText
                : generatedText // ignore: cast_nullable_to_non_nullable
                      as String,
            sourceMemoryId: freezed == sourceMemoryId
                ? _value.sourceMemoryId
                : sourceMemoryId // ignore: cast_nullable_to_non_nullable
                      as String?,
            tokensUsed: null == tokensUsed
                ? _value.tokensUsed
                : tokensUsed // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryGenerationResponseImplCopyWith<$Res>
    implements $StoryGenerationResponseCopyWith<$Res> {
  factory _$$StoryGenerationResponseImplCopyWith(
    _$StoryGenerationResponseImpl value,
    $Res Function(_$StoryGenerationResponseImpl) then,
  ) = __$$StoryGenerationResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(name: 'story_type') String storyType,
    @JsonKey(name: 'generated_text') String generatedText,
    @JsonKey(name: 'source_memory_id') String? sourceMemoryId,
    @JsonKey(name: 'tokens_used') int tokensUsed,
  });
}

/// @nodoc
class __$$StoryGenerationResponseImplCopyWithImpl<$Res>
    extends
        _$StoryGenerationResponseCopyWithImpl<
          $Res,
          _$StoryGenerationResponseImpl
        >
    implements _$$StoryGenerationResponseImplCopyWith<$Res> {
  __$$StoryGenerationResponseImplCopyWithImpl(
    _$StoryGenerationResponseImpl _value,
    $Res Function(_$StoryGenerationResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryGenerationResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? storyType = null,
    Object? generatedText = null,
    Object? sourceMemoryId = freezed,
    Object? tokensUsed = null,
  }) {
    return _then(
      _$StoryGenerationResponseImpl(
        storyType: null == storyType
            ? _value.storyType
            : storyType // ignore: cast_nullable_to_non_nullable
                  as String,
        generatedText: null == generatedText
            ? _value.generatedText
            : generatedText // ignore: cast_nullable_to_non_nullable
                  as String,
        sourceMemoryId: freezed == sourceMemoryId
            ? _value.sourceMemoryId
            : sourceMemoryId // ignore: cast_nullable_to_non_nullable
                  as String?,
        tokensUsed: null == tokensUsed
            ? _value.tokensUsed
            : tokensUsed // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryGenerationResponseImpl
    with DiagnosticableTreeMixin
    implements _StoryGenerationResponse {
  const _$StoryGenerationResponseImpl({
    @JsonKey(name: 'story_type') required this.storyType,
    @JsonKey(name: 'generated_text') required this.generatedText,
    @JsonKey(name: 'source_memory_id') this.sourceMemoryId,
    @JsonKey(name: 'tokens_used') required this.tokensUsed,
  });

  factory _$StoryGenerationResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryGenerationResponseImplFromJson(json);

  @override
  @JsonKey(name: 'story_type')
  final String storyType;
  @override
  @JsonKey(name: 'generated_text')
  final String generatedText;
  @override
  @JsonKey(name: 'source_memory_id')
  final String? sourceMemoryId;
  @override
  @JsonKey(name: 'tokens_used')
  final int tokensUsed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'StoryGenerationResponse(storyType: $storyType, generatedText: $generatedText, sourceMemoryId: $sourceMemoryId, tokensUsed: $tokensUsed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'StoryGenerationResponse'))
      ..add(DiagnosticsProperty('storyType', storyType))
      ..add(DiagnosticsProperty('generatedText', generatedText))
      ..add(DiagnosticsProperty('sourceMemoryId', sourceMemoryId))
      ..add(DiagnosticsProperty('tokensUsed', tokensUsed));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryGenerationResponseImpl &&
            (identical(other.storyType, storyType) ||
                other.storyType == storyType) &&
            (identical(other.generatedText, generatedText) ||
                other.generatedText == generatedText) &&
            (identical(other.sourceMemoryId, sourceMemoryId) ||
                other.sourceMemoryId == sourceMemoryId) &&
            (identical(other.tokensUsed, tokensUsed) ||
                other.tokensUsed == tokensUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    storyType,
    generatedText,
    sourceMemoryId,
    tokensUsed,
  );

  /// Create a copy of StoryGenerationResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryGenerationResponseImplCopyWith<_$StoryGenerationResponseImpl>
  get copyWith =>
      __$$StoryGenerationResponseImplCopyWithImpl<
        _$StoryGenerationResponseImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryGenerationResponseImplToJson(this);
  }
}

abstract class _StoryGenerationResponse implements StoryGenerationResponse {
  const factory _StoryGenerationResponse({
    @JsonKey(name: 'story_type') required final String storyType,
    @JsonKey(name: 'generated_text') required final String generatedText,
    @JsonKey(name: 'source_memory_id') final String? sourceMemoryId,
    @JsonKey(name: 'tokens_used') required final int tokensUsed,
  }) = _$StoryGenerationResponseImpl;

  factory _StoryGenerationResponse.fromJson(Map<String, dynamic> json) =
      _$StoryGenerationResponseImpl.fromJson;

  @override
  @JsonKey(name: 'story_type')
  String get storyType;
  @override
  @JsonKey(name: 'generated_text')
  String get generatedText;
  @override
  @JsonKey(name: 'source_memory_id')
  String? get sourceMemoryId;
  @override
  @JsonKey(name: 'tokens_used')
  int get tokensUsed;

  /// Create a copy of StoryGenerationResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryGenerationResponseImplCopyWith<_$StoryGenerationResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

ChatMessage _$ChatMessageFromJson(Map<String, dynamic> json) {
  return _ChatMessage.fromJson(json);
}

/// @nodoc
mixin _$ChatMessage {
  String get role => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;

  /// Serializes this ChatMessage to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatMessageCopyWith<ChatMessage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatMessageCopyWith<$Res> {
  factory $ChatMessageCopyWith(
    ChatMessage value,
    $Res Function(ChatMessage) then,
  ) = _$ChatMessageCopyWithImpl<$Res, ChatMessage>;
  @useResult
  $Res call({String role, String content});
}

/// @nodoc
class _$ChatMessageCopyWithImpl<$Res, $Val extends ChatMessage>
    implements $ChatMessageCopyWith<$Res> {
  _$ChatMessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = null, Object? content = null}) {
    return _then(
      _value.copyWith(
            role: null == role
                ? _value.role
                : role // ignore: cast_nullable_to_non_nullable
                      as String,
            content: null == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatMessageImplCopyWith<$Res>
    implements $ChatMessageCopyWith<$Res> {
  factory _$$ChatMessageImplCopyWith(
    _$ChatMessageImpl value,
    $Res Function(_$ChatMessageImpl) then,
  ) = __$$ChatMessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String role, String content});
}

/// @nodoc
class __$$ChatMessageImplCopyWithImpl<$Res>
    extends _$ChatMessageCopyWithImpl<$Res, _$ChatMessageImpl>
    implements _$$ChatMessageImplCopyWith<$Res> {
  __$$ChatMessageImplCopyWithImpl(
    _$ChatMessageImpl _value,
    $Res Function(_$ChatMessageImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? role = null, Object? content = null}) {
    return _then(
      _$ChatMessageImpl(
        role: null == role
            ? _value.role
            : role // ignore: cast_nullable_to_non_nullable
                  as String,
        content: null == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatMessageImpl with DiagnosticableTreeMixin implements _ChatMessage {
  const _$ChatMessageImpl({required this.role, required this.content});

  factory _$ChatMessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatMessageImplFromJson(json);

  @override
  final String role;
  @override
  final String content;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatMessage(role: $role, content: $content)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatMessage'))
      ..add(DiagnosticsProperty('role', role))
      ..add(DiagnosticsProperty('content', content));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatMessageImpl &&
            (identical(other.role, role) || other.role == role) &&
            (identical(other.content, content) || other.content == content));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, role, content);

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      __$$ChatMessageImplCopyWithImpl<_$ChatMessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatMessageImplToJson(this);
  }
}

abstract class _ChatMessage implements ChatMessage {
  const factory _ChatMessage({
    required final String role,
    required final String content,
  }) = _$ChatMessageImpl;

  factory _ChatMessage.fromJson(Map<String, dynamic> json) =
      _$ChatMessageImpl.fromJson;

  @override
  String get role;
  @override
  String get content;

  /// Create a copy of ChatMessage
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatMessageImplCopyWith<_$ChatMessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatWithPastRequest _$ChatWithPastRequestFromJson(Map<String, dynamic> json) {
  return _ChatWithPastRequest.fromJson(json);
}

/// @nodoc
mixin _$ChatWithPastRequest {
  String get message => throw _privateConstructorUsedError;
  @JsonKey(name: 'conversation_history')
  List<ChatMessage>? get conversationHistory =>
      throw _privateConstructorUsedError;

  /// Serializes this ChatWithPastRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatWithPastRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatWithPastRequestCopyWith<ChatWithPastRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatWithPastRequestCopyWith<$Res> {
  factory $ChatWithPastRequestCopyWith(
    ChatWithPastRequest value,
    $Res Function(ChatWithPastRequest) then,
  ) = _$ChatWithPastRequestCopyWithImpl<$Res, ChatWithPastRequest>;
  @useResult
  $Res call({
    String message,
    @JsonKey(name: 'conversation_history')
    List<ChatMessage>? conversationHistory,
  });
}

/// @nodoc
class _$ChatWithPastRequestCopyWithImpl<$Res, $Val extends ChatWithPastRequest>
    implements $ChatWithPastRequestCopyWith<$Res> {
  _$ChatWithPastRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatWithPastRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? conversationHistory = freezed}) {
    return _then(
      _value.copyWith(
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            conversationHistory: freezed == conversationHistory
                ? _value.conversationHistory
                : conversationHistory // ignore: cast_nullable_to_non_nullable
                      as List<ChatMessage>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatWithPastRequestImplCopyWith<$Res>
    implements $ChatWithPastRequestCopyWith<$Res> {
  factory _$$ChatWithPastRequestImplCopyWith(
    _$ChatWithPastRequestImpl value,
    $Res Function(_$ChatWithPastRequestImpl) then,
  ) = __$$ChatWithPastRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String message,
    @JsonKey(name: 'conversation_history')
    List<ChatMessage>? conversationHistory,
  });
}

/// @nodoc
class __$$ChatWithPastRequestImplCopyWithImpl<$Res>
    extends _$ChatWithPastRequestCopyWithImpl<$Res, _$ChatWithPastRequestImpl>
    implements _$$ChatWithPastRequestImplCopyWith<$Res> {
  __$$ChatWithPastRequestImplCopyWithImpl(
    _$ChatWithPastRequestImpl _value,
    $Res Function(_$ChatWithPastRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatWithPastRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? message = null, Object? conversationHistory = freezed}) {
    return _then(
      _$ChatWithPastRequestImpl(
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        conversationHistory: freezed == conversationHistory
            ? _value._conversationHistory
            : conversationHistory // ignore: cast_nullable_to_non_nullable
                  as List<ChatMessage>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatWithPastRequestImpl
    with DiagnosticableTreeMixin
    implements _ChatWithPastRequest {
  const _$ChatWithPastRequestImpl({
    required this.message,
    @JsonKey(name: 'conversation_history')
    final List<ChatMessage>? conversationHistory,
  }) : _conversationHistory = conversationHistory;

  factory _$ChatWithPastRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatWithPastRequestImplFromJson(json);

  @override
  final String message;
  final List<ChatMessage>? _conversationHistory;
  @override
  @JsonKey(name: 'conversation_history')
  List<ChatMessage>? get conversationHistory {
    final value = _conversationHistory;
    if (value == null) return null;
    if (_conversationHistory is EqualUnmodifiableListView)
      return _conversationHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatWithPastRequest(message: $message, conversationHistory: $conversationHistory)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatWithPastRequest'))
      ..add(DiagnosticsProperty('message', message))
      ..add(DiagnosticsProperty('conversationHistory', conversationHistory));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatWithPastRequestImpl &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._conversationHistory,
              _conversationHistory,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    message,
    const DeepCollectionEquality().hash(_conversationHistory),
  );

  /// Create a copy of ChatWithPastRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatWithPastRequestImplCopyWith<_$ChatWithPastRequestImpl> get copyWith =>
      __$$ChatWithPastRequestImplCopyWithImpl<_$ChatWithPastRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatWithPastRequestImplToJson(this);
  }
}

abstract class _ChatWithPastRequest implements ChatWithPastRequest {
  const factory _ChatWithPastRequest({
    required final String message,
    @JsonKey(name: 'conversation_history')
    final List<ChatMessage>? conversationHistory,
  }) = _$ChatWithPastRequestImpl;

  factory _ChatWithPastRequest.fromJson(Map<String, dynamic> json) =
      _$ChatWithPastRequestImpl.fromJson;

  @override
  String get message;
  @override
  @JsonKey(name: 'conversation_history')
  List<ChatMessage>? get conversationHistory;

  /// Create a copy of ChatWithPastRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatWithPastRequestImplCopyWith<_$ChatWithPastRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatWithPastResponse _$ChatWithPastResponseFromJson(Map<String, dynamic> json) {
  return _ChatWithPastResponse.fromJson(json);
}

/// @nodoc
mixin _$ChatWithPastResponse {
  String get response => throw _privateConstructorUsedError;
  @JsonKey(name: 'tokens_used')
  int get tokensUsed => throw _privateConstructorUsedError;

  /// Serializes this ChatWithPastResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ChatWithPastResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatWithPastResponseCopyWith<ChatWithPastResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatWithPastResponseCopyWith<$Res> {
  factory $ChatWithPastResponseCopyWith(
    ChatWithPastResponse value,
    $Res Function(ChatWithPastResponse) then,
  ) = _$ChatWithPastResponseCopyWithImpl<$Res, ChatWithPastResponse>;
  @useResult
  $Res call({String response, @JsonKey(name: 'tokens_used') int tokensUsed});
}

/// @nodoc
class _$ChatWithPastResponseCopyWithImpl<
  $Res,
  $Val extends ChatWithPastResponse
>
    implements $ChatWithPastResponseCopyWith<$Res> {
  _$ChatWithPastResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatWithPastResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? response = null, Object? tokensUsed = null}) {
    return _then(
      _value.copyWith(
            response: null == response
                ? _value.response
                : response // ignore: cast_nullable_to_non_nullable
                      as String,
            tokensUsed: null == tokensUsed
                ? _value.tokensUsed
                : tokensUsed // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatWithPastResponseImplCopyWith<$Res>
    implements $ChatWithPastResponseCopyWith<$Res> {
  factory _$$ChatWithPastResponseImplCopyWith(
    _$ChatWithPastResponseImpl value,
    $Res Function(_$ChatWithPastResponseImpl) then,
  ) = __$$ChatWithPastResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String response, @JsonKey(name: 'tokens_used') int tokensUsed});
}

/// @nodoc
class __$$ChatWithPastResponseImplCopyWithImpl<$Res>
    extends _$ChatWithPastResponseCopyWithImpl<$Res, _$ChatWithPastResponseImpl>
    implements _$$ChatWithPastResponseImplCopyWith<$Res> {
  __$$ChatWithPastResponseImplCopyWithImpl(
    _$ChatWithPastResponseImpl _value,
    $Res Function(_$ChatWithPastResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatWithPastResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? response = null, Object? tokensUsed = null}) {
    return _then(
      _$ChatWithPastResponseImpl(
        response: null == response
            ? _value.response
            : response // ignore: cast_nullable_to_non_nullable
                  as String,
        tokensUsed: null == tokensUsed
            ? _value.tokensUsed
            : tokensUsed // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatWithPastResponseImpl
    with DiagnosticableTreeMixin
    implements _ChatWithPastResponse {
  const _$ChatWithPastResponseImpl({
    required this.response,
    @JsonKey(name: 'tokens_used') required this.tokensUsed,
  });

  factory _$ChatWithPastResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatWithPastResponseImplFromJson(json);

  @override
  final String response;
  @override
  @JsonKey(name: 'tokens_used')
  final int tokensUsed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChatWithPastResponse(response: $response, tokensUsed: $tokensUsed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChatWithPastResponse'))
      ..add(DiagnosticsProperty('response', response))
      ..add(DiagnosticsProperty('tokensUsed', tokensUsed));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatWithPastResponseImpl &&
            (identical(other.response, response) ||
                other.response == response) &&
            (identical(other.tokensUsed, tokensUsed) ||
                other.tokensUsed == tokensUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, response, tokensUsed);

  /// Create a copy of ChatWithPastResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatWithPastResponseImplCopyWith<_$ChatWithPastResponseImpl>
  get copyWith =>
      __$$ChatWithPastResponseImplCopyWithImpl<_$ChatWithPastResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatWithPastResponseImplToJson(this);
  }
}

abstract class _ChatWithPastResponse implements ChatWithPastResponse {
  const factory _ChatWithPastResponse({
    required final String response,
    @JsonKey(name: 'tokens_used') required final int tokensUsed,
  }) = _$ChatWithPastResponseImpl;

  factory _ChatWithPastResponse.fromJson(Map<String, dynamic> json) =
      _$ChatWithPastResponseImpl.fromJson;

  @override
  String get response;
  @override
  @JsonKey(name: 'tokens_used')
  int get tokensUsed;

  /// Create a copy of ChatWithPastResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatWithPastResponseImplCopyWith<_$ChatWithPastResponseImpl>
  get copyWith => throw _privateConstructorUsedError;
}

YearSummaryRequest _$YearSummaryRequestFromJson(Map<String, dynamic> json) {
  return _YearSummaryRequest.fromJson(json);
}

/// @nodoc
mixin _$YearSummaryRequest {
  int? get year => throw _privateConstructorUsedError;

  /// Serializes this YearSummaryRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YearSummaryRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YearSummaryRequestCopyWith<YearSummaryRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YearSummaryRequestCopyWith<$Res> {
  factory $YearSummaryRequestCopyWith(
    YearSummaryRequest value,
    $Res Function(YearSummaryRequest) then,
  ) = _$YearSummaryRequestCopyWithImpl<$Res, YearSummaryRequest>;
  @useResult
  $Res call({int? year});
}

/// @nodoc
class _$YearSummaryRequestCopyWithImpl<$Res, $Val extends YearSummaryRequest>
    implements $YearSummaryRequestCopyWith<$Res> {
  _$YearSummaryRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YearSummaryRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? year = freezed}) {
    return _then(
      _value.copyWith(
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$YearSummaryRequestImplCopyWith<$Res>
    implements $YearSummaryRequestCopyWith<$Res> {
  factory _$$YearSummaryRequestImplCopyWith(
    _$YearSummaryRequestImpl value,
    $Res Function(_$YearSummaryRequestImpl) then,
  ) = __$$YearSummaryRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? year});
}

/// @nodoc
class __$$YearSummaryRequestImplCopyWithImpl<$Res>
    extends _$YearSummaryRequestCopyWithImpl<$Res, _$YearSummaryRequestImpl>
    implements _$$YearSummaryRequestImplCopyWith<$Res> {
  __$$YearSummaryRequestImplCopyWithImpl(
    _$YearSummaryRequestImpl _value,
    $Res Function(_$YearSummaryRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YearSummaryRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? year = freezed}) {
    return _then(
      _$YearSummaryRequestImpl(
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YearSummaryRequestImpl
    with DiagnosticableTreeMixin
    implements _YearSummaryRequest {
  const _$YearSummaryRequestImpl({this.year});

  factory _$YearSummaryRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearSummaryRequestImplFromJson(json);

  @override
  final int? year;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'YearSummaryRequest(year: $year)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'YearSummaryRequest'))
      ..add(DiagnosticsProperty('year', year));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearSummaryRequestImpl &&
            (identical(other.year, year) || other.year == year));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, year);

  /// Create a copy of YearSummaryRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearSummaryRequestImplCopyWith<_$YearSummaryRequestImpl> get copyWith =>
      __$$YearSummaryRequestImplCopyWithImpl<_$YearSummaryRequestImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$YearSummaryRequestImplToJson(this);
  }
}

abstract class _YearSummaryRequest implements YearSummaryRequest {
  const factory _YearSummaryRequest({final int? year}) =
      _$YearSummaryRequestImpl;

  factory _YearSummaryRequest.fromJson(Map<String, dynamic> json) =
      _$YearSummaryRequestImpl.fromJson;

  @override
  int? get year;

  /// Create a copy of YearSummaryRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearSummaryRequestImplCopyWith<_$YearSummaryRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

YearSummaryResponse _$YearSummaryResponseFromJson(Map<String, dynamic> json) {
  return _YearSummaryResponse.fromJson(json);
}

/// @nodoc
mixin _$YearSummaryResponse {
  int get year => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  @JsonKey(name: 'memories_count')
  int get memoriesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'tokens_used')
  int get tokensUsed => throw _privateConstructorUsedError;

  /// Serializes this YearSummaryResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of YearSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $YearSummaryResponseCopyWith<YearSummaryResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $YearSummaryResponseCopyWith<$Res> {
  factory $YearSummaryResponseCopyWith(
    YearSummaryResponse value,
    $Res Function(YearSummaryResponse) then,
  ) = _$YearSummaryResponseCopyWithImpl<$Res, YearSummaryResponse>;
  @useResult
  $Res call({
    int year,
    String summary,
    @JsonKey(name: 'memories_count') int memoriesCount,
    @JsonKey(name: 'tokens_used') int tokensUsed,
  });
}

/// @nodoc
class _$YearSummaryResponseCopyWithImpl<$Res, $Val extends YearSummaryResponse>
    implements $YearSummaryResponseCopyWith<$Res> {
  _$YearSummaryResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of YearSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? summary = null,
    Object? memoriesCount = null,
    Object? tokensUsed = null,
  }) {
    return _then(
      _value.copyWith(
            year: null == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as int,
            summary: null == summary
                ? _value.summary
                : summary // ignore: cast_nullable_to_non_nullable
                      as String,
            memoriesCount: null == memoriesCount
                ? _value.memoriesCount
                : memoriesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            tokensUsed: null == tokensUsed
                ? _value.tokensUsed
                : tokensUsed // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$YearSummaryResponseImplCopyWith<$Res>
    implements $YearSummaryResponseCopyWith<$Res> {
  factory _$$YearSummaryResponseImplCopyWith(
    _$YearSummaryResponseImpl value,
    $Res Function(_$YearSummaryResponseImpl) then,
  ) = __$$YearSummaryResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int year,
    String summary,
    @JsonKey(name: 'memories_count') int memoriesCount,
    @JsonKey(name: 'tokens_used') int tokensUsed,
  });
}

/// @nodoc
class __$$YearSummaryResponseImplCopyWithImpl<$Res>
    extends _$YearSummaryResponseCopyWithImpl<$Res, _$YearSummaryResponseImpl>
    implements _$$YearSummaryResponseImplCopyWith<$Res> {
  __$$YearSummaryResponseImplCopyWithImpl(
    _$YearSummaryResponseImpl _value,
    $Res Function(_$YearSummaryResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of YearSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? year = null,
    Object? summary = null,
    Object? memoriesCount = null,
    Object? tokensUsed = null,
  }) {
    return _then(
      _$YearSummaryResponseImpl(
        year: null == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as int,
        summary: null == summary
            ? _value.summary
            : summary // ignore: cast_nullable_to_non_nullable
                  as String,
        memoriesCount: null == memoriesCount
            ? _value.memoriesCount
            : memoriesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        tokensUsed: null == tokensUsed
            ? _value.tokensUsed
            : tokensUsed // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$YearSummaryResponseImpl
    with DiagnosticableTreeMixin
    implements _YearSummaryResponse {
  const _$YearSummaryResponseImpl({
    required this.year,
    required this.summary,
    @JsonKey(name: 'memories_count') required this.memoriesCount,
    @JsonKey(name: 'tokens_used') required this.tokensUsed,
  });

  factory _$YearSummaryResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$YearSummaryResponseImplFromJson(json);

  @override
  final int year;
  @override
  final String summary;
  @override
  @JsonKey(name: 'memories_count')
  final int memoriesCount;
  @override
  @JsonKey(name: 'tokens_used')
  final int tokensUsed;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'YearSummaryResponse(year: $year, summary: $summary, memoriesCount: $memoriesCount, tokensUsed: $tokensUsed)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'YearSummaryResponse'))
      ..add(DiagnosticsProperty('year', year))
      ..add(DiagnosticsProperty('summary', summary))
      ..add(DiagnosticsProperty('memoriesCount', memoriesCount))
      ..add(DiagnosticsProperty('tokensUsed', tokensUsed));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$YearSummaryResponseImpl &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.memoriesCount, memoriesCount) ||
                other.memoriesCount == memoriesCount) &&
            (identical(other.tokensUsed, tokensUsed) ||
                other.tokensUsed == tokensUsed));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, year, summary, memoriesCount, tokensUsed);

  /// Create a copy of YearSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$YearSummaryResponseImplCopyWith<_$YearSummaryResponseImpl> get copyWith =>
      __$$YearSummaryResponseImplCopyWithImpl<_$YearSummaryResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$YearSummaryResponseImplToJson(this);
  }
}

abstract class _YearSummaryResponse implements YearSummaryResponse {
  const factory _YearSummaryResponse({
    required final int year,
    required final String summary,
    @JsonKey(name: 'memories_count') required final int memoriesCount,
    @JsonKey(name: 'tokens_used') required final int tokensUsed,
  }) = _$YearSummaryResponseImpl;

  factory _YearSummaryResponse.fromJson(Map<String, dynamic> json) =
      _$YearSummaryResponseImpl.fromJson;

  @override
  int get year;
  @override
  String get summary;
  @override
  @JsonKey(name: 'memories_count')
  int get memoriesCount;
  @override
  @JsonKey(name: 'tokens_used')
  int get tokensUsed;

  /// Create a copy of YearSummaryResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$YearSummaryResponseImplCopyWith<_$YearSummaryResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
