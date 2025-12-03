import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/features/smart_search/data/models/search_result_model.dart';

class ContentResultCard extends StatelessWidget {
  final ContentResult result;
  final VoidCallback onTap;

  const ContentResultCard({
    super.key,
    required this.result,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        gradient: isDark
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.surfaceColor.withOpacity(0.7),
                  AppTheme.cardColor.withOpacity(0.5),
                ],
              )
            : null,
        color: isDark ? null : Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark
              ? Colors.white.withOpacity(0.1)
              : Colors.black.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.black.withOpacity(0.2)
                : Colors.black.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image
                if (result.imageUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: result.imageUrl!,
                      width: 80,
                      height: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        width: 80,
                        height: 120,
                        color: isDark ? Colors.white10 : Colors.black12,
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        width: 80,
                        height: 120,
                        color: isDark ? Colors.white10 : Colors.black12,
                        child: Icon(
                          _getIconForType(result.type),
                          color: isDark ? Colors.white30 : Colors.black26,
                        ),
                      ),
                    ),
                  )
                else
                  Container(
                    width: 80,
                    height: 120,
                    decoration: BoxDecoration(
                      gradient: AppTheme.primaryGradient,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getIconForType(result.type),
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                const SizedBox(width: 12),

                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        result.title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),

                      // Metadata row
                      Wrap(
                        spacing: 8,
                        runSpacing: 4,
                        children: [
                          // Source badge
                          _buildBadge(
                            context,
                            _getSourceLabel(result.source),
                            Ionicons.earth_outline,
                          ),

                          // Year
                          if (result.year != null)
                            _buildBadge(
                              context,
                              result.year!,
                              Ionicons.calendar_outline,
                            ),

                          // Rating
                          if (result.rating != null)
                            _buildBadge(
                              context,
                              '⭐ ${result.rating!.toStringAsFixed(1)}',
                              null,
                            ),
                        ],
                      ),
                      const SizedBox(height: 8),

                      // Description
                      if (result.description != null &&
                          result.description!.isNotEmpty)
                        Text(
                          result.description!,
                          style:
                              Theme.of(context).textTheme.bodySmall?.copyWith(
                                    height: 1.4,
                                    color: isDark
                                        ? Colors.white70
                                        : Colors.black54,
                                  ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),

                      // Director/Authors
                      if (result.director != null ||
                          (result.authors != null && result.authors!.isNotEmpty))
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            result.director != null
                                ? '🎬 ${result.director}'
                                : '✍️ ${result.authors!.join(", ")}',
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.primaryColor,
                                ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                    ],
                  ),
                ),

                // Arrow
                Icon(
                  Ionicons.chevron_forward,
                  color: isDark ? Colors.white30 : Colors.black26,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, String label, IconData? icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withOpacity(0.1)
            : Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 12,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForType(String type) {
    switch (type) {
      case 'movie':
        return Ionicons.film_outline;
      case 'book':
        return Ionicons.book_outline;
      case 'recipe':
        return Ionicons.restaurant_outline;
      case 'place':
        return Ionicons.location_outline;
      case 'product':
        return Ionicons.cart_outline;
      default:
        return Ionicons.globe_outline;
    }
  }

  String _getSourceLabel(String source) {
    switch (source) {
      case 'tmdb':
        return 'TMDB';
      case 'google_books':
        return 'Google Books';
      case 'web':
        return 'Web';
      default:
        return source.toUpperCase();
    }
  }
}

