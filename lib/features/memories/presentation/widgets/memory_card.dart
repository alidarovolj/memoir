import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:ionicons/ionicons.dart';

class MemoryCard extends StatelessWidget {
  final String title;
  final String content;
  final String? category;
  final List<String>? tags;
  final DateTime createdAt;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const MemoryCard({
    super.key,
    required this.title,
    required this.content,
    this.category,
    this.tags,
    required this.createdAt,
    this.onTap,
    this.onEdit,
    this.onDelete,
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
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header с категорией и действиями
                Row(
                  children: [
                    if (category != null) ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Ionicons.apps,
                              size: 14,
                              color: Colors.white,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              category!,
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                    ],
                    if (category == null) const Spacer(),
                    
                    // Действия
                    if (onEdit != null)
                      IconButton(
                        icon: const Icon(Ionicons.create_outline, size: 20),
                        onPressed: onEdit,
                        color: isDark ? Colors.white70 : Colors.black54,
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                    if (onDelete != null)
                      IconButton(
                        icon: const Icon(Ionicons.trash_outline, size: 20),
                        onPressed: onDelete,
                        color: isDark ? Colors.red.shade300 : Colors.red.shade400,
                        padding: const EdgeInsets.all(8),
                        constraints: const BoxConstraints(),
                      ),
                  ],
                ),
                const SizedBox(height: 12),

                // Заголовок
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Контент
                Text(
                  content,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.5,
                      ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),

                // Теги
                if (tags != null && tags!.isNotEmpty) ...[
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: tags!.take(3).map((tag) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: AppTheme.primaryColor.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Ionicons.pricetag,
                              size: 12,
                              color: AppTheme.primaryColor,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              tag,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 12),
                ],

                // Footer с датой
                Row(
                  children: [
                    Icon(
                      Ionicons.time_outline,
                      size: 14,
                      color: isDark 
                          ? Colors.white.withOpacity(0.5)
                          : Colors.black45,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      _formatDate(createdAt),
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark 
                            ? Colors.white.withOpacity(0.5)
                            : Colors.black45,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
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

