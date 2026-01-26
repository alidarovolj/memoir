// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'friendship_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

FriendProfile _$FriendProfileFromJson(Map<String, dynamic> json) {
  return _FriendProfile.fromJson(json);
}

/// @nodoc
mixin _$FriendProfile {
  String get id => throw _privateConstructorUsedError;
  String get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'first_name')
  String? get firstName => throw _privateConstructorUsedError;
  @JsonKey(name: 'last_name')
  String? get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'memories_count')
  int get memoriesCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'friends_count')
  int get friendsCount => throw _privateConstructorUsedError;
  @JsonKey(name: 'streak_days')
  int get streakDays => throw _privateConstructorUsedError; // Personal data
  String? get profession => throw _privateConstructorUsedError;
  @JsonKey(name: 'telegram_url')
  String? get telegramUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'whatsapp_url')
  String? get whatsappUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'youtube_url')
  String? get youtubeUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'linkedin_url')
  String? get linkedinUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'about_me')
  String? get aboutMe => throw _privateConstructorUsedError;
  String? get city => throw _privateConstructorUsedError;
  @JsonKey(name: 'date_of_birth')
  DateTime? get dateOfBirth => throw _privateConstructorUsedError;
  String? get education => throw _privateConstructorUsedError;
  String? get hobbies => throw _privateConstructorUsedError;

  /// Serializes this FriendProfile to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendProfileCopyWith<FriendProfile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendProfileCopyWith<$Res> {
  factory $FriendProfileCopyWith(
    FriendProfile value,
    $Res Function(FriendProfile) then,
  ) = _$FriendProfileCopyWithImpl<$Res, FriendProfile>;
  @useResult
  $Res call({
    String id,
    String username,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'memories_count') int memoriesCount,
    @JsonKey(name: 'friends_count') int friendsCount,
    @JsonKey(name: 'streak_days') int streakDays,
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
  });
}

/// @nodoc
class _$FriendProfileCopyWithImpl<$Res, $Val extends FriendProfile>
    implements $FriendProfileCopyWith<$Res> {
  _$FriendProfileCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? avatarUrl = freezed,
    Object? createdAt = null,
    Object? memoriesCount = null,
    Object? friendsCount = null,
    Object? streakDays = null,
    Object? profession = freezed,
    Object? telegramUrl = freezed,
    Object? whatsappUrl = freezed,
    Object? youtubeUrl = freezed,
    Object? linkedinUrl = freezed,
    Object? aboutMe = freezed,
    Object? city = freezed,
    Object? dateOfBirth = freezed,
    Object? education = freezed,
    Object? hobbies = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            username: null == username
                ? _value.username
                : username // ignore: cast_nullable_to_non_nullable
                      as String,
            firstName: freezed == firstName
                ? _value.firstName
                : firstName // ignore: cast_nullable_to_non_nullable
                      as String?,
            lastName: freezed == lastName
                ? _value.lastName
                : lastName // ignore: cast_nullable_to_non_nullable
                      as String?,
            avatarUrl: freezed == avatarUrl
                ? _value.avatarUrl
                : avatarUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            memoriesCount: null == memoriesCount
                ? _value.memoriesCount
                : memoriesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            friendsCount: null == friendsCount
                ? _value.friendsCount
                : friendsCount // ignore: cast_nullable_to_non_nullable
                      as int,
            streakDays: null == streakDays
                ? _value.streakDays
                : streakDays // ignore: cast_nullable_to_non_nullable
                      as int,
            profession: freezed == profession
                ? _value.profession
                : profession // ignore: cast_nullable_to_non_nullable
                      as String?,
            telegramUrl: freezed == telegramUrl
                ? _value.telegramUrl
                : telegramUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            whatsappUrl: freezed == whatsappUrl
                ? _value.whatsappUrl
                : whatsappUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            youtubeUrl: freezed == youtubeUrl
                ? _value.youtubeUrl
                : youtubeUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            linkedinUrl: freezed == linkedinUrl
                ? _value.linkedinUrl
                : linkedinUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            aboutMe: freezed == aboutMe
                ? _value.aboutMe
                : aboutMe // ignore: cast_nullable_to_non_nullable
                      as String?,
            city: freezed == city
                ? _value.city
                : city // ignore: cast_nullable_to_non_nullable
                      as String?,
            dateOfBirth: freezed == dateOfBirth
                ? _value.dateOfBirth
                : dateOfBirth // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            education: freezed == education
                ? _value.education
                : education // ignore: cast_nullable_to_non_nullable
                      as String?,
            hobbies: freezed == hobbies
                ? _value.hobbies
                : hobbies // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$FriendProfileImplCopyWith<$Res>
    implements $FriendProfileCopyWith<$Res> {
  factory _$$FriendProfileImplCopyWith(
    _$FriendProfileImpl value,
    $Res Function(_$FriendProfileImpl) then,
  ) = __$$FriendProfileImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String username,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'memories_count') int memoriesCount,
    @JsonKey(name: 'friends_count') int friendsCount,
    @JsonKey(name: 'streak_days') int streakDays,
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
  });
}

/// @nodoc
class __$$FriendProfileImplCopyWithImpl<$Res>
    extends _$FriendProfileCopyWithImpl<$Res, _$FriendProfileImpl>
    implements _$$FriendProfileImplCopyWith<$Res> {
  __$$FriendProfileImplCopyWithImpl(
    _$FriendProfileImpl _value,
    $Res Function(_$FriendProfileImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendProfile
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? username = null,
    Object? firstName = freezed,
    Object? lastName = freezed,
    Object? avatarUrl = freezed,
    Object? createdAt = null,
    Object? memoriesCount = null,
    Object? friendsCount = null,
    Object? streakDays = null,
    Object? profession = freezed,
    Object? telegramUrl = freezed,
    Object? whatsappUrl = freezed,
    Object? youtubeUrl = freezed,
    Object? linkedinUrl = freezed,
    Object? aboutMe = freezed,
    Object? city = freezed,
    Object? dateOfBirth = freezed,
    Object? education = freezed,
    Object? hobbies = freezed,
  }) {
    return _then(
      _$FriendProfileImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        username: null == username
            ? _value.username
            : username // ignore: cast_nullable_to_non_nullable
                  as String,
        firstName: freezed == firstName
            ? _value.firstName
            : firstName // ignore: cast_nullable_to_non_nullable
                  as String?,
        lastName: freezed == lastName
            ? _value.lastName
            : lastName // ignore: cast_nullable_to_non_nullable
                  as String?,
        avatarUrl: freezed == avatarUrl
            ? _value.avatarUrl
            : avatarUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        memoriesCount: null == memoriesCount
            ? _value.memoriesCount
            : memoriesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        friendsCount: null == friendsCount
            ? _value.friendsCount
            : friendsCount // ignore: cast_nullable_to_non_nullable
                  as int,
        streakDays: null == streakDays
            ? _value.streakDays
            : streakDays // ignore: cast_nullable_to_non_nullable
                  as int,
        profession: freezed == profession
            ? _value.profession
            : profession // ignore: cast_nullable_to_non_nullable
                  as String?,
        telegramUrl: freezed == telegramUrl
            ? _value.telegramUrl
            : telegramUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        whatsappUrl: freezed == whatsappUrl
            ? _value.whatsappUrl
            : whatsappUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        youtubeUrl: freezed == youtubeUrl
            ? _value.youtubeUrl
            : youtubeUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        linkedinUrl: freezed == linkedinUrl
            ? _value.linkedinUrl
            : linkedinUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        aboutMe: freezed == aboutMe
            ? _value.aboutMe
            : aboutMe // ignore: cast_nullable_to_non_nullable
                  as String?,
        city: freezed == city
            ? _value.city
            : city // ignore: cast_nullable_to_non_nullable
                  as String?,
        dateOfBirth: freezed == dateOfBirth
            ? _value.dateOfBirth
            : dateOfBirth // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        education: freezed == education
            ? _value.education
            : education // ignore: cast_nullable_to_non_nullable
                  as String?,
        hobbies: freezed == hobbies
            ? _value.hobbies
            : hobbies // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendProfileImpl extends _FriendProfile {
  const _$FriendProfileImpl({
    required this.id,
    required this.username,
    @JsonKey(name: 'first_name') this.firstName,
    @JsonKey(name: 'last_name') this.lastName,
    @JsonKey(name: 'avatar_url') this.avatarUrl,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'memories_count') this.memoriesCount = 0,
    @JsonKey(name: 'friends_count') this.friendsCount = 0,
    @JsonKey(name: 'streak_days') this.streakDays = 0,
    this.profession,
    @JsonKey(name: 'telegram_url') this.telegramUrl,
    @JsonKey(name: 'whatsapp_url') this.whatsappUrl,
    @JsonKey(name: 'youtube_url') this.youtubeUrl,
    @JsonKey(name: 'linkedin_url') this.linkedinUrl,
    @JsonKey(name: 'about_me') this.aboutMe,
    this.city,
    @JsonKey(name: 'date_of_birth') this.dateOfBirth,
    this.education,
    this.hobbies,
  }) : super._();

  factory _$FriendProfileImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendProfileImplFromJson(json);

  @override
  final String id;
  @override
  final String username;
  @override
  @JsonKey(name: 'first_name')
  final String? firstName;
  @override
  @JsonKey(name: 'last_name')
  final String? lastName;
  @override
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'memories_count')
  final int memoriesCount;
  @override
  @JsonKey(name: 'friends_count')
  final int friendsCount;
  @override
  @JsonKey(name: 'streak_days')
  final int streakDays;
  // Personal data
  @override
  final String? profession;
  @override
  @JsonKey(name: 'telegram_url')
  final String? telegramUrl;
  @override
  @JsonKey(name: 'whatsapp_url')
  final String? whatsappUrl;
  @override
  @JsonKey(name: 'youtube_url')
  final String? youtubeUrl;
  @override
  @JsonKey(name: 'linkedin_url')
  final String? linkedinUrl;
  @override
  @JsonKey(name: 'about_me')
  final String? aboutMe;
  @override
  final String? city;
  @override
  @JsonKey(name: 'date_of_birth')
  final DateTime? dateOfBirth;
  @override
  final String? education;
  @override
  final String? hobbies;

  @override
  String toString() {
    return 'FriendProfile(id: $id, username: $username, firstName: $firstName, lastName: $lastName, avatarUrl: $avatarUrl, createdAt: $createdAt, memoriesCount: $memoriesCount, friendsCount: $friendsCount, streakDays: $streakDays, profession: $profession, telegramUrl: $telegramUrl, whatsappUrl: $whatsappUrl, youtubeUrl: $youtubeUrl, linkedinUrl: $linkedinUrl, aboutMe: $aboutMe, city: $city, dateOfBirth: $dateOfBirth, education: $education, hobbies: $hobbies)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendProfileImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.avatarUrl, avatarUrl) ||
                other.avatarUrl == avatarUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.memoriesCount, memoriesCount) ||
                other.memoriesCount == memoriesCount) &&
            (identical(other.friendsCount, friendsCount) ||
                other.friendsCount == friendsCount) &&
            (identical(other.streakDays, streakDays) ||
                other.streakDays == streakDays) &&
            (identical(other.profession, profession) ||
                other.profession == profession) &&
            (identical(other.telegramUrl, telegramUrl) ||
                other.telegramUrl == telegramUrl) &&
            (identical(other.whatsappUrl, whatsappUrl) ||
                other.whatsappUrl == whatsappUrl) &&
            (identical(other.youtubeUrl, youtubeUrl) ||
                other.youtubeUrl == youtubeUrl) &&
            (identical(other.linkedinUrl, linkedinUrl) ||
                other.linkedinUrl == linkedinUrl) &&
            (identical(other.aboutMe, aboutMe) || other.aboutMe == aboutMe) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.dateOfBirth, dateOfBirth) ||
                other.dateOfBirth == dateOfBirth) &&
            (identical(other.education, education) ||
                other.education == education) &&
            (identical(other.hobbies, hobbies) || other.hobbies == hobbies));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
    runtimeType,
    id,
    username,
    firstName,
    lastName,
    avatarUrl,
    createdAt,
    memoriesCount,
    friendsCount,
    streakDays,
    profession,
    telegramUrl,
    whatsappUrl,
    youtubeUrl,
    linkedinUrl,
    aboutMe,
    city,
    dateOfBirth,
    education,
    hobbies,
  ]);

  /// Create a copy of FriendProfile
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendProfileImplCopyWith<_$FriendProfileImpl> get copyWith =>
      __$$FriendProfileImplCopyWithImpl<_$FriendProfileImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendProfileImplToJson(this);
  }
}

abstract class _FriendProfile extends FriendProfile {
  const factory _FriendProfile({
    required final String id,
    required final String username,
    @JsonKey(name: 'first_name') final String? firstName,
    @JsonKey(name: 'last_name') final String? lastName,
    @JsonKey(name: 'avatar_url') final String? avatarUrl,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'memories_count') final int memoriesCount,
    @JsonKey(name: 'friends_count') final int friendsCount,
    @JsonKey(name: 'streak_days') final int streakDays,
    final String? profession,
    @JsonKey(name: 'telegram_url') final String? telegramUrl,
    @JsonKey(name: 'whatsapp_url') final String? whatsappUrl,
    @JsonKey(name: 'youtube_url') final String? youtubeUrl,
    @JsonKey(name: 'linkedin_url') final String? linkedinUrl,
    @JsonKey(name: 'about_me') final String? aboutMe,
    final String? city,
    @JsonKey(name: 'date_of_birth') final DateTime? dateOfBirth,
    final String? education,
    final String? hobbies,
  }) = _$FriendProfileImpl;
  const _FriendProfile._() : super._();

  factory _FriendProfile.fromJson(Map<String, dynamic> json) =
      _$FriendProfileImpl.fromJson;

  @override
  String get id;
  @override
  String get username;
  @override
  @JsonKey(name: 'first_name')
  String? get firstName;
  @override
  @JsonKey(name: 'last_name')
  String? get lastName;
  @override
  @JsonKey(name: 'avatar_url')
  String? get avatarUrl;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'memories_count')
  int get memoriesCount;
  @override
  @JsonKey(name: 'friends_count')
  int get friendsCount;
  @override
  @JsonKey(name: 'streak_days')
  int get streakDays; // Personal data
  @override
  String? get profession;
  @override
  @JsonKey(name: 'telegram_url')
  String? get telegramUrl;
  @override
  @JsonKey(name: 'whatsapp_url')
  String? get whatsappUrl;
  @override
  @JsonKey(name: 'youtube_url')
  String? get youtubeUrl;
  @override
  @JsonKey(name: 'linkedin_url')
  String? get linkedinUrl;
  @override
  @JsonKey(name: 'about_me')
  String? get aboutMe;
  @override
  String? get city;
  @override
  @JsonKey(name: 'date_of_birth')
  DateTime? get dateOfBirth;
  @override
  String? get education;
  @override
  String? get hobbies;

  /// Create a copy of FriendProfile
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendProfileImplCopyWith<_$FriendProfileImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendshipModel _$FriendshipModelFromJson(Map<String, dynamic> json) {
  return _FriendshipModel.fromJson(json);
}

/// @nodoc
mixin _$FriendshipModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'requester_id')
  String get requesterId => throw _privateConstructorUsedError;
  @JsonKey(name: 'addressee_id')
  String get addresseeId => throw _privateConstructorUsedError;
  FriendshipStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt => throw _privateConstructorUsedError;
  FriendProfile? get friend => throw _privateConstructorUsedError;

  /// Serializes this FriendshipModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendshipModelCopyWith<FriendshipModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendshipModelCopyWith<$Res> {
  factory $FriendshipModelCopyWith(
    FriendshipModel value,
    $Res Function(FriendshipModel) then,
  ) = _$FriendshipModelCopyWithImpl<$Res, FriendshipModel>;
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'requester_id') String requesterId,
    @JsonKey(name: 'addressee_id') String addresseeId,
    FriendshipStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    FriendProfile? friend,
  });

  $FriendProfileCopyWith<$Res>? get friend;
}

/// @nodoc
class _$FriendshipModelCopyWithImpl<$Res, $Val extends FriendshipModel>
    implements $FriendshipModelCopyWith<$Res> {
  _$FriendshipModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requesterId = null,
    Object? addresseeId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? friend = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            requesterId: null == requesterId
                ? _value.requesterId
                : requesterId // ignore: cast_nullable_to_non_nullable
                      as String,
            addresseeId: null == addresseeId
                ? _value.addresseeId
                : addresseeId // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as FriendshipStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            updatedAt: null == updatedAt
                ? _value.updatedAt
                : updatedAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            friend: freezed == friend
                ? _value.friend
                : friend // ignore: cast_nullable_to_non_nullable
                      as FriendProfile?,
          )
          as $Val,
    );
  }

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendProfileCopyWith<$Res>? get friend {
    if (_value.friend == null) {
      return null;
    }

    return $FriendProfileCopyWith<$Res>(_value.friend!, (value) {
      return _then(_value.copyWith(friend: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendshipModelImplCopyWith<$Res>
    implements $FriendshipModelCopyWith<$Res> {
  factory _$$FriendshipModelImplCopyWith(
    _$FriendshipModelImpl value,
    $Res Function(_$FriendshipModelImpl) then,
  ) = __$$FriendshipModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    @JsonKey(name: 'requester_id') String requesterId,
    @JsonKey(name: 'addressee_id') String addresseeId,
    FriendshipStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    @JsonKey(name: 'updated_at') DateTime updatedAt,
    FriendProfile? friend,
  });

  @override
  $FriendProfileCopyWith<$Res>? get friend;
}

/// @nodoc
class __$$FriendshipModelImplCopyWithImpl<$Res>
    extends _$FriendshipModelCopyWithImpl<$Res, _$FriendshipModelImpl>
    implements _$$FriendshipModelImplCopyWith<$Res> {
  __$$FriendshipModelImplCopyWithImpl(
    _$FriendshipModelImpl _value,
    $Res Function(_$FriendshipModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? requesterId = null,
    Object? addresseeId = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? friend = freezed,
  }) {
    return _then(
      _$FriendshipModelImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        requesterId: null == requesterId
            ? _value.requesterId
            : requesterId // ignore: cast_nullable_to_non_nullable
                  as String,
        addresseeId: null == addresseeId
            ? _value.addresseeId
            : addresseeId // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as FriendshipStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        updatedAt: null == updatedAt
            ? _value.updatedAt
            : updatedAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        friend: freezed == friend
            ? _value.friend
            : friend // ignore: cast_nullable_to_non_nullable
                  as FriendProfile?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendshipModelImpl implements _FriendshipModel {
  const _$FriendshipModelImpl({
    required this.id,
    @JsonKey(name: 'requester_id') required this.requesterId,
    @JsonKey(name: 'addressee_id') required this.addresseeId,
    required this.status,
    @JsonKey(name: 'created_at') required this.createdAt,
    @JsonKey(name: 'updated_at') required this.updatedAt,
    this.friend,
  });

  factory _$FriendshipModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendshipModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: 'requester_id')
  final String requesterId;
  @override
  @JsonKey(name: 'addressee_id')
  final String addresseeId;
  @override
  final FriendshipStatus status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @override
  final FriendProfile? friend;

  @override
  String toString() {
    return 'FriendshipModel(id: $id, requesterId: $requesterId, addresseeId: $addresseeId, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, friend: $friend)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendshipModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.requesterId, requesterId) ||
                other.requesterId == requesterId) &&
            (identical(other.addresseeId, addresseeId) ||
                other.addresseeId == addresseeId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.friend, friend) || other.friend == friend));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    requesterId,
    addresseeId,
    status,
    createdAt,
    updatedAt,
    friend,
  );

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendshipModelImplCopyWith<_$FriendshipModelImpl> get copyWith =>
      __$$FriendshipModelImplCopyWithImpl<_$FriendshipModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendshipModelImplToJson(this);
  }
}

abstract class _FriendshipModel implements FriendshipModel {
  const factory _FriendshipModel({
    required final String id,
    @JsonKey(name: 'requester_id') required final String requesterId,
    @JsonKey(name: 'addressee_id') required final String addresseeId,
    required final FriendshipStatus status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    @JsonKey(name: 'updated_at') required final DateTime updatedAt,
    final FriendProfile? friend,
  }) = _$FriendshipModelImpl;

  factory _FriendshipModel.fromJson(Map<String, dynamic> json) =
      _$FriendshipModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: 'requester_id')
  String get requesterId;
  @override
  @JsonKey(name: 'addressee_id')
  String get addresseeId;
  @override
  FriendshipStatus get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'updated_at')
  DateTime get updatedAt;
  @override
  FriendProfile? get friend;

  /// Create a copy of FriendshipModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendshipModelImplCopyWith<_$FriendshipModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

FriendRequest _$FriendRequestFromJson(Map<String, dynamic> json) {
  return _FriendRequest.fromJson(json);
}

/// @nodoc
mixin _$FriendRequest {
  String get id => throw _privateConstructorUsedError;
  FriendshipStatus get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  FriendProfile get requester => throw _privateConstructorUsedError;

  /// Serializes this FriendRequest to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $FriendRequestCopyWith<FriendRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FriendRequestCopyWith<$Res> {
  factory $FriendRequestCopyWith(
    FriendRequest value,
    $Res Function(FriendRequest) then,
  ) = _$FriendRequestCopyWithImpl<$Res, FriendRequest>;
  @useResult
  $Res call({
    String id,
    FriendshipStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    FriendProfile requester,
  });

  $FriendProfileCopyWith<$Res> get requester;
}

/// @nodoc
class _$FriendRequestCopyWithImpl<$Res, $Val extends FriendRequest>
    implements $FriendRequestCopyWith<$Res> {
  _$FriendRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? createdAt = null,
    Object? requester = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as FriendshipStatus,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            requester: null == requester
                ? _value.requester
                : requester // ignore: cast_nullable_to_non_nullable
                      as FriendProfile,
          )
          as $Val,
    );
  }

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FriendProfileCopyWith<$Res> get requester {
    return $FriendProfileCopyWith<$Res>(_value.requester, (value) {
      return _then(_value.copyWith(requester: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$FriendRequestImplCopyWith<$Res>
    implements $FriendRequestCopyWith<$Res> {
  factory _$$FriendRequestImplCopyWith(
    _$FriendRequestImpl value,
    $Res Function(_$FriendRequestImpl) then,
  ) = __$$FriendRequestImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    FriendshipStatus status,
    @JsonKey(name: 'created_at') DateTime createdAt,
    FriendProfile requester,
  });

  @override
  $FriendProfileCopyWith<$Res> get requester;
}

/// @nodoc
class __$$FriendRequestImplCopyWithImpl<$Res>
    extends _$FriendRequestCopyWithImpl<$Res, _$FriendRequestImpl>
    implements _$$FriendRequestImplCopyWith<$Res> {
  __$$FriendRequestImplCopyWithImpl(
    _$FriendRequestImpl _value,
    $Res Function(_$FriendRequestImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? status = null,
    Object? createdAt = null,
    Object? requester = null,
  }) {
    return _then(
      _$FriendRequestImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as FriendshipStatus,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        requester: null == requester
            ? _value.requester
            : requester // ignore: cast_nullable_to_non_nullable
                  as FriendProfile,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$FriendRequestImpl implements _FriendRequest {
  const _$FriendRequestImpl({
    required this.id,
    required this.status,
    @JsonKey(name: 'created_at') required this.createdAt,
    required this.requester,
  });

  factory _$FriendRequestImpl.fromJson(Map<String, dynamic> json) =>
      _$$FriendRequestImplFromJson(json);

  @override
  final String id;
  @override
  final FriendshipStatus status;
  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  final FriendProfile requester;

  @override
  String toString() {
    return 'FriendRequest(id: $id, status: $status, createdAt: $createdAt, requester: $requester)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FriendRequestImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.requester, requester) ||
                other.requester == requester));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, status, createdAt, requester);

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$FriendRequestImplCopyWith<_$FriendRequestImpl> get copyWith =>
      __$$FriendRequestImplCopyWithImpl<_$FriendRequestImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FriendRequestImplToJson(this);
  }
}

abstract class _FriendRequest implements FriendRequest {
  const factory _FriendRequest({
    required final String id,
    required final FriendshipStatus status,
    @JsonKey(name: 'created_at') required final DateTime createdAt,
    required final FriendProfile requester,
  }) = _$FriendRequestImpl;

  factory _FriendRequest.fromJson(Map<String, dynamic> json) =
      _$FriendRequestImpl.fromJson;

  @override
  String get id;
  @override
  FriendshipStatus get status;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  FriendProfile get requester;

  /// Create a copy of FriendRequest
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$FriendRequestImplCopyWith<_$FriendRequestImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
