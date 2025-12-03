// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_result_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$SmartSearchResponse {
  String get intent => throw _privateConstructorUsedError;
  String get searchQuery => throw _privateConstructorUsedError;
  bool get needsSearch => throw _privateConstructorUsedError;
  double get confidence => throw _privateConstructorUsedError;
  Map<String, dynamic> get sources => throw _privateConstructorUsedError;

  /// Create a copy of SmartSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $SmartSearchResponseCopyWith<SmartSearchResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SmartSearchResponseCopyWith<$Res> {
  factory $SmartSearchResponseCopyWith(
    SmartSearchResponse value,
    $Res Function(SmartSearchResponse) then,
  ) = _$SmartSearchResponseCopyWithImpl<$Res, SmartSearchResponse>;
  @useResult
  $Res call({
    String intent,
    String searchQuery,
    bool needsSearch,
    double confidence,
    Map<String, dynamic> sources,
  });
}

/// @nodoc
class _$SmartSearchResponseCopyWithImpl<$Res, $Val extends SmartSearchResponse>
    implements $SmartSearchResponseCopyWith<$Res> {
  _$SmartSearchResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of SmartSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intent = null,
    Object? searchQuery = null,
    Object? needsSearch = null,
    Object? confidence = null,
    Object? sources = null,
  }) {
    return _then(
      _value.copyWith(
            intent: null == intent
                ? _value.intent
                : intent // ignore: cast_nullable_to_non_nullable
                      as String,
            searchQuery: null == searchQuery
                ? _value.searchQuery
                : searchQuery // ignore: cast_nullable_to_non_nullable
                      as String,
            needsSearch: null == needsSearch
                ? _value.needsSearch
                : needsSearch // ignore: cast_nullable_to_non_nullable
                      as bool,
            confidence: null == confidence
                ? _value.confidence
                : confidence // ignore: cast_nullable_to_non_nullable
                      as double,
            sources: null == sources
                ? _value.sources
                : sources // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$SmartSearchResponseImplCopyWith<$Res>
    implements $SmartSearchResponseCopyWith<$Res> {
  factory _$$SmartSearchResponseImplCopyWith(
    _$SmartSearchResponseImpl value,
    $Res Function(_$SmartSearchResponseImpl) then,
  ) = __$$SmartSearchResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String intent,
    String searchQuery,
    bool needsSearch,
    double confidence,
    Map<String, dynamic> sources,
  });
}

/// @nodoc
class __$$SmartSearchResponseImplCopyWithImpl<$Res>
    extends _$SmartSearchResponseCopyWithImpl<$Res, _$SmartSearchResponseImpl>
    implements _$$SmartSearchResponseImplCopyWith<$Res> {
  __$$SmartSearchResponseImplCopyWithImpl(
    _$SmartSearchResponseImpl _value,
    $Res Function(_$SmartSearchResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of SmartSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intent = null,
    Object? searchQuery = null,
    Object? needsSearch = null,
    Object? confidence = null,
    Object? sources = null,
  }) {
    return _then(
      _$SmartSearchResponseImpl(
        intent: null == intent
            ? _value.intent
            : intent // ignore: cast_nullable_to_non_nullable
                  as String,
        searchQuery: null == searchQuery
            ? _value.searchQuery
            : searchQuery // ignore: cast_nullable_to_non_nullable
                  as String,
        needsSearch: null == needsSearch
            ? _value.needsSearch
            : needsSearch // ignore: cast_nullable_to_non_nullable
                  as bool,
        confidence: null == confidence
            ? _value.confidence
            : confidence // ignore: cast_nullable_to_non_nullable
                  as double,
        sources: null == sources
            ? _value._sources
            : sources // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc

class _$SmartSearchResponseImpl implements _SmartSearchResponse {
  const _$SmartSearchResponseImpl({
    required this.intent,
    required this.searchQuery,
    required this.needsSearch,
    required this.confidence,
    required final Map<String, dynamic> sources,
  }) : _sources = sources;

  @override
  final String intent;
  @override
  final String searchQuery;
  @override
  final bool needsSearch;
  @override
  final double confidence;
  final Map<String, dynamic> _sources;
  @override
  Map<String, dynamic> get sources {
    if (_sources is EqualUnmodifiableMapView) return _sources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_sources);
  }

  @override
  String toString() {
    return 'SmartSearchResponse(intent: $intent, searchQuery: $searchQuery, needsSearch: $needsSearch, confidence: $confidence, sources: $sources)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SmartSearchResponseImpl &&
            (identical(other.intent, intent) || other.intent == intent) &&
            (identical(other.searchQuery, searchQuery) ||
                other.searchQuery == searchQuery) &&
            (identical(other.needsSearch, needsSearch) ||
                other.needsSearch == needsSearch) &&
            (identical(other.confidence, confidence) ||
                other.confidence == confidence) &&
            const DeepCollectionEquality().equals(other._sources, _sources));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    intent,
    searchQuery,
    needsSearch,
    confidence,
    const DeepCollectionEquality().hash(_sources),
  );

  /// Create a copy of SmartSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$SmartSearchResponseImplCopyWith<_$SmartSearchResponseImpl> get copyWith =>
      __$$SmartSearchResponseImplCopyWithImpl<_$SmartSearchResponseImpl>(
        this,
        _$identity,
      );
}

abstract class _SmartSearchResponse implements SmartSearchResponse {
  const factory _SmartSearchResponse({
    required final String intent,
    required final String searchQuery,
    required final bool needsSearch,
    required final double confidence,
    required final Map<String, dynamic> sources,
  }) = _$SmartSearchResponseImpl;

  @override
  String get intent;
  @override
  String get searchQuery;
  @override
  bool get needsSearch;
  @override
  double get confidence;
  @override
  Map<String, dynamic> get sources;

  /// Create a copy of SmartSearchResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$SmartSearchResponseImplCopyWith<_$SmartSearchResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ContentResult {
  String? get externalId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get imageUrl => throw _privateConstructorUsedError;
  String? get backdropUrl => throw _privateConstructorUsedError;
  String? get year => throw _privateConstructorUsedError;
  double? get rating => throw _privateConstructorUsedError;
  String? get director => throw _privateConstructorUsedError;
  List<String>? get actors => throw _privateConstructorUsedError;
  List<String>? get genres => throw _privateConstructorUsedError;
  List<String>? get authors => throw _privateConstructorUsedError;
  String? get publisher => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String get source => throw _privateConstructorUsedError;
  String get type => throw _privateConstructorUsedError;
  Map<String, dynamic>? get metadata => throw _privateConstructorUsedError;

  /// Create a copy of ContentResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContentResultCopyWith<ContentResult> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContentResultCopyWith<$Res> {
  factory $ContentResultCopyWith(
    ContentResult value,
    $Res Function(ContentResult) then,
  ) = _$ContentResultCopyWithImpl<$Res, ContentResult>;
  @useResult
  $Res call({
    String? externalId,
    String title,
    String? description,
    String? imageUrl,
    String? backdropUrl,
    String? year,
    double? rating,
    String? director,
    List<String>? actors,
    List<String>? genres,
    List<String>? authors,
    String? publisher,
    String? url,
    String source,
    String type,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class _$ContentResultCopyWithImpl<$Res, $Val extends ContentResult>
    implements $ContentResultCopyWith<$Res> {
  _$ContentResultCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContentResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalId = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? backdropUrl = freezed,
    Object? year = freezed,
    Object? rating = freezed,
    Object? director = freezed,
    Object? actors = freezed,
    Object? genres = freezed,
    Object? authors = freezed,
    Object? publisher = freezed,
    Object? url = freezed,
    Object? source = null,
    Object? type = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _value.copyWith(
            externalId: freezed == externalId
                ? _value.externalId
                : externalId // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            backdropUrl: freezed == backdropUrl
                ? _value.backdropUrl
                : backdropUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
            year: freezed == year
                ? _value.year
                : year // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: freezed == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double?,
            director: freezed == director
                ? _value.director
                : director // ignore: cast_nullable_to_non_nullable
                      as String?,
            actors: freezed == actors
                ? _value.actors
                : actors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            genres: freezed == genres
                ? _value.genres
                : genres // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            authors: freezed == authors
                ? _value.authors
                : authors // ignore: cast_nullable_to_non_nullable
                      as List<String>?,
            publisher: freezed == publisher
                ? _value.publisher
                : publisher // ignore: cast_nullable_to_non_nullable
                      as String?,
            url: freezed == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String?,
            source: null == source
                ? _value.source
                : source // ignore: cast_nullable_to_non_nullable
                      as String,
            type: null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                      as String,
            metadata: freezed == metadata
                ? _value.metadata
                : metadata // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContentResultImplCopyWith<$Res>
    implements $ContentResultCopyWith<$Res> {
  factory _$$ContentResultImplCopyWith(
    _$ContentResultImpl value,
    $Res Function(_$ContentResultImpl) then,
  ) = __$$ContentResultImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? externalId,
    String title,
    String? description,
    String? imageUrl,
    String? backdropUrl,
    String? year,
    double? rating,
    String? director,
    List<String>? actors,
    List<String>? genres,
    List<String>? authors,
    String? publisher,
    String? url,
    String source,
    String type,
    Map<String, dynamic>? metadata,
  });
}

/// @nodoc
class __$$ContentResultImplCopyWithImpl<$Res>
    extends _$ContentResultCopyWithImpl<$Res, _$ContentResultImpl>
    implements _$$ContentResultImplCopyWith<$Res> {
  __$$ContentResultImplCopyWithImpl(
    _$ContentResultImpl _value,
    $Res Function(_$ContentResultImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContentResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? externalId = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? imageUrl = freezed,
    Object? backdropUrl = freezed,
    Object? year = freezed,
    Object? rating = freezed,
    Object? director = freezed,
    Object? actors = freezed,
    Object? genres = freezed,
    Object? authors = freezed,
    Object? publisher = freezed,
    Object? url = freezed,
    Object? source = null,
    Object? type = null,
    Object? metadata = freezed,
  }) {
    return _then(
      _$ContentResultImpl(
        externalId: freezed == externalId
            ? _value.externalId
            : externalId // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        backdropUrl: freezed == backdropUrl
            ? _value.backdropUrl
            : backdropUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
        year: freezed == year
            ? _value.year
            : year // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: freezed == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double?,
        director: freezed == director
            ? _value.director
            : director // ignore: cast_nullable_to_non_nullable
                  as String?,
        actors: freezed == actors
            ? _value._actors
            : actors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        genres: freezed == genres
            ? _value._genres
            : genres // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        authors: freezed == authors
            ? _value._authors
            : authors // ignore: cast_nullable_to_non_nullable
                  as List<String>?,
        publisher: freezed == publisher
            ? _value.publisher
            : publisher // ignore: cast_nullable_to_non_nullable
                  as String?,
        url: freezed == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String?,
        source: null == source
            ? _value.source
            : source // ignore: cast_nullable_to_non_nullable
                  as String,
        type: null == type
            ? _value.type
            : type // ignore: cast_nullable_to_non_nullable
                  as String,
        metadata: freezed == metadata
            ? _value._metadata
            : metadata // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc

class _$ContentResultImpl implements _ContentResult {
  const _$ContentResultImpl({
    this.externalId,
    required this.title,
    this.description,
    this.imageUrl,
    this.backdropUrl,
    this.year,
    this.rating,
    this.director,
    final List<String>? actors,
    final List<String>? genres,
    final List<String>? authors,
    this.publisher,
    this.url,
    required this.source,
    required this.type,
    final Map<String, dynamic>? metadata,
  }) : _actors = actors,
       _genres = genres,
       _authors = authors,
       _metadata = metadata;

  @override
  final String? externalId;
  @override
  final String title;
  @override
  final String? description;
  @override
  final String? imageUrl;
  @override
  final String? backdropUrl;
  @override
  final String? year;
  @override
  final double? rating;
  @override
  final String? director;
  final List<String>? _actors;
  @override
  List<String>? get actors {
    final value = _actors;
    if (value == null) return null;
    if (_actors is EqualUnmodifiableListView) return _actors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _genres;
  @override
  List<String>? get genres {
    final value = _genres;
    if (value == null) return null;
    if (_genres is EqualUnmodifiableListView) return _genres;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _authors;
  @override
  List<String>? get authors {
    final value = _authors;
    if (value == null) return null;
    if (_authors is EqualUnmodifiableListView) return _authors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? publisher;
  @override
  final String? url;
  @override
  final String source;
  @override
  final String type;
  final Map<String, dynamic>? _metadata;
  @override
  Map<String, dynamic>? get metadata {
    final value = _metadata;
    if (value == null) return null;
    if (_metadata is EqualUnmodifiableMapView) return _metadata;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'ContentResult(externalId: $externalId, title: $title, description: $description, imageUrl: $imageUrl, backdropUrl: $backdropUrl, year: $year, rating: $rating, director: $director, actors: $actors, genres: $genres, authors: $authors, publisher: $publisher, url: $url, source: $source, type: $type, metadata: $metadata)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContentResultImpl &&
            (identical(other.externalId, externalId) ||
                other.externalId == externalId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.backdropUrl, backdropUrl) ||
                other.backdropUrl == backdropUrl) &&
            (identical(other.year, year) || other.year == year) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.director, director) ||
                other.director == director) &&
            const DeepCollectionEquality().equals(other._actors, _actors) &&
            const DeepCollectionEquality().equals(other._genres, _genres) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            (identical(other.publisher, publisher) ||
                other.publisher == publisher) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.source, source) || other.source == source) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._metadata, _metadata));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    externalId,
    title,
    description,
    imageUrl,
    backdropUrl,
    year,
    rating,
    director,
    const DeepCollectionEquality().hash(_actors),
    const DeepCollectionEquality().hash(_genres),
    const DeepCollectionEquality().hash(_authors),
    publisher,
    url,
    source,
    type,
    const DeepCollectionEquality().hash(_metadata),
  );

  /// Create a copy of ContentResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContentResultImplCopyWith<_$ContentResultImpl> get copyWith =>
      __$$ContentResultImplCopyWithImpl<_$ContentResultImpl>(this, _$identity);
}

abstract class _ContentResult implements ContentResult {
  const factory _ContentResult({
    final String? externalId,
    required final String title,
    final String? description,
    final String? imageUrl,
    final String? backdropUrl,
    final String? year,
    final double? rating,
    final String? director,
    final List<String>? actors,
    final List<String>? genres,
    final List<String>? authors,
    final String? publisher,
    final String? url,
    required final String source,
    required final String type,
    final Map<String, dynamic>? metadata,
  }) = _$ContentResultImpl;

  @override
  String? get externalId;
  @override
  String get title;
  @override
  String? get description;
  @override
  String? get imageUrl;
  @override
  String? get backdropUrl;
  @override
  String? get year;
  @override
  double? get rating;
  @override
  String? get director;
  @override
  List<String>? get actors;
  @override
  List<String>? get genres;
  @override
  List<String>? get authors;
  @override
  String? get publisher;
  @override
  String? get url;
  @override
  String get source;
  @override
  String get type;
  @override
  Map<String, dynamic>? get metadata;

  /// Create a copy of ContentResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContentResultImplCopyWith<_$ContentResultImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
