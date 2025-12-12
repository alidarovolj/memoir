import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MemoryCard extends StatelessWidget {
  final String title;
  final String content;
  final String? category;
  final List<String>? tags;
  final DateTime createdAt;
  final String? imageUrl; // Poster/cover image
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final double? aiConfidence; // AI confidence score (0-1)
  final bool isAiProcessing; // Whether AI is currently processing

  const MemoryCard({
    super.key,
    required this.title,
    required this.content,
    this.category,
    this.tags,
    required this.createdAt,
    this.imageUrl,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.aiConfidence,
    this.isAiProcessing = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppTheme.cardColor : Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(24),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final cardHeight = constraints.maxHeight;
                final topImageHeight =
                    cardHeight * 0.57; // ~57% высоты карточки

                return SizedBox(
                  height: cardHeight > 0 ? cardHeight : 420,
                  child: Stack(
                    children: [
                      // Background image (blurred) - занимает всю карточку
                      Positioned.fill(
                        child: imageUrl != null && imageUrl!.isNotEmpty
                            ? ImageFiltered(
                                imageFilter: ImageFilter.blur(
                                  sigmaX: 20,
                                  sigmaY: 20,
                                ),
                                child: CachedNetworkImage(
                                  imageUrl: imageUrl!,
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Container(
                                    decoration: BoxDecoration(
                                      gradient: AppTheme.primaryGradient
                                          .withOpacity(0.3),
                                    ),
                                    child: const Center(
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Container(
                                        decoration: BoxDecoration(
                                          gradient: AppTheme.primaryGradient
                                              .withOpacity(0.3),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Ionicons.image_outline,
                                            color: Colors.white,
                                            size: 48,
                                          ),
                                        ),
                                      ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient
                                      .withOpacity(0.3),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Ionicons.image_outline,
                                    color: Colors.white,
                                    size: 48,
                                  ),
                                ),
                              ),
                      ),

                      // Четкое изображение в верхней части
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        height: topImageHeight,
                        child: imageUrl != null && imageUrl!.isNotEmpty
                            ? CachedNetworkImage(
                                imageUrl: imageUrl!,
                                fit: BoxFit.contain,
                                alignment: Alignment.topCenter,
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    gradient: AppTheme.primaryGradient
                                        .withOpacity(0.3),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    gradient: AppTheme.primaryGradient
                                        .withOpacity(0.3),
                                  ),
                                ),
                              )
                            : Container(
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient
                                      .withOpacity(0.3),
                                ),
                              ),
                      ),

                      // Gradient overlay для плавного перехода от четкого фото к блюру
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Colors.black.withOpacity(0.2),
                              ],
                              stops: const [0.0, 0.5, 1.0],
                            ),
                          ),
                        ),
                      ),

                      // AI Processing indicator (top)
                      if (isAiProcessing)
                        Positioned(
                          top: 16,
                          right: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.accentColor.withOpacity(0.95),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(
                                  width: 12,
                                  height: 12,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    valueColor: AlwaysStoppedAnimation(
                                      Colors.white,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Text(
                                  'AI Processing...',
                                  style: TextStyle(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                      // Content at bottom with blur effect
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(24),
                            bottomRight: Radius.circular(24),
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.5),
                                    Colors.black.withOpacity(0.75),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Builder(
                                  builder: (context) {
                                    final hasBadges =
                                        aiConfidence != null ||
                                        category != null;
                                    final hasDescription = content.isNotEmpty;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        // Title
                                        Text(
                                          title,
                                          style: const TextStyle(
                                            fontSize: 13,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                            letterSpacing: 0,
                                            height: 1.25, // 20/16 = 1.25
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // Отступ между заголовком и описанием только если есть описание
                                        if (hasDescription)
                                          const SizedBox(height: 15),

                                        // Description
                                        if (hasDescription)
                                          Text(
                                            content,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.white.withOpacity(
                                                0.85,
                                              ),
                                              height: 1.214, // 17/14 ≈ 1.214
                                              letterSpacing: 0,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        // Отступ между описанием и бейджами только если есть и описание, и бейджи
                                        if (hasDescription && hasBadges)
                                          const SizedBox(height: 16),

                                        // Rating and date info
                                        if (hasBadges)
                                          Row(
                                            children: [
                                              // Rating with stars
                                              if (aiConfidence != null)
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 6,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: Row(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      Text(
                                                        (aiConfidence! * 5)
                                                            .toStringAsFixed(1),
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 6),
                                                      ...List.generate(5, (
                                                        index,
                                                      ) {
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                left: 2,
                                                              ),
                                                          child: Icon(
                                                            index <
                                                                    (aiConfidence! *
                                                                            5)
                                                                        .round()
                                                                ? Ionicons.star
                                                                : Ionicons
                                                                      .star_outline,
                                                            size: 12,
                                                            color: Colors.amber,
                                                          ),
                                                        );
                                                      }),
                                                    ],
                                                  ),
                                                ),
                                              if (aiConfidence != null &&
                                                  category != null)
                                                const SizedBox(width: 8),

                                              // Date badge
                                              if (category != null)
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 6,
                                                      ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white
                                                        .withOpacity(0.15),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    category!,
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                            ],
                                          ),
                                        // Отступ между бейджами и кнопкой только если есть бейджи
                                        if (hasBadges)
                                          const SizedBox(height: 16),

                                        // Action button
                                        // const SizedBox(height: 16),
                                        // SizedBox(
                                        //   width: double.infinity,
                                        //   child: ElevatedButton(
                                        //     onPressed: onTap,
                                        //     style: ElevatedButton.styleFrom(
                                        //       backgroundColor: Colors.white,
                                        //       foregroundColor: Colors.black,
                                        //       padding:
                                        //           const EdgeInsets.symmetric(
                                        //             vertical: 8,
                                        //           ),
                                        //       shape: RoundedRectangleBorder(
                                        //         borderRadius:
                                        //             BorderRadius.circular(50),
                                        //       ),
                                        //       elevation: 0,
                                        //     ),
                                        //     child: const Text(
                                        //       'Открыть',
                                        //       style: TextStyle(
                                        //         fontSize: 12,
                                        //         fontWeight: FontWeight.w700,
                                        //         letterSpacing: 0,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'Только что';
        }
        return '${difference.inMinutes} мин назад';
      }
      return '${difference.inHours} ч назад';
    } else if (difference.inDays == 1) {
      return 'Вчера';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} дн назад';
    } else {
      return '${date.day}.${date.month.toString().padLeft(2, '0')}.${date.year}';
    }
  }
}
