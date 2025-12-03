import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_model.freezed.dart';

@freezed
class SmartSearchResponse with _$SmartSearchResponse {
  const factory SmartSearchResponse({
    required String intent,
    required String searchQuery,
    required bool needsSearch,
    required double confidence,
    required Map<String, dynamic> sources,
  }) = _SmartSearchResponse;

  factory SmartSearchResponse.fromJson(Map<String, dynamic> json) {
    return SmartSearchResponse(
      intent: json['intent'] as String,
      searchQuery: json['search_query'] as String,
      needsSearch: json['needs_search'] as bool,
      confidence: (json['confidence'] as num).toDouble(),
      sources: json['sources'] as Map<String, dynamic>,
    );
  }
}

@Freezed()
class ContentResult with _$ContentResult {
  const factory ContentResult({
    String? externalId,
    required String title,
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
    required String source,
    required String type,
    Map<String, dynamic>? metadata,
  }) = _ContentResult;

  factory ContentResult.fromJson(Map<String, dynamic> json) {
    return ContentResult(
      externalId: json['external_id'] as String?,
      title: json['title'] as String,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
      backdropUrl: json['backdrop_url'] as String?,
      year: json['year'] as String?,
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
      director: json['director'] as String?,
      actors: json['actors'] != null
          ? List<String>.from(json['actors'] as List)
          : null,
      genres: json['genres'] != null
          ? List<String>.from(json['genres'] as List)
          : null,
      authors: json['authors'] != null
          ? List<String>.from(json['authors'] as List)
          : null,
      publisher: json['publisher'] as String?,
      url: json['url'] as String?,
      source: json['source'] as String,
      type: json['type'] as String,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );
  }
}
