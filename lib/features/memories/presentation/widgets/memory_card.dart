import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:ionicons/ionicons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:memoir/core/widgets/audio_player_widget.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/features/memories/data/datasources/memory_reactions_datasource.dart';
import 'package:memoir/features/memories/data/models/memory_reactions_model.dart';
import 'package:memoir/features/memories/presentation/widgets/comments_section.dart';

class MemoryCard extends StatefulWidget {
  final String memoryId;
  final String title;
  final String content;
  final String? category;
  final List<String>? tags;
  final DateTime createdAt;
  final String? imageUrl;
  final String? sourceUrl; // Ссылка
  final String? audioUrl; // Аудио
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final double? aiConfidence;
  final bool isAiProcessing;
  final String? authorName;
  final String? authorAvatar;
  final bool isOwnPost; // Новое поле для определения, свой ли это пост
  final int reactionsCount; // Количество реакций (лайков)
  final int commentsCount; // Количество комментариев
  final int sharesCount; // Количество шаров
  final int viewsCount; // Количество просмотров
  final bool isReacted; // Лайкнул ли текущий пользователь

  const MemoryCard({
    super.key,
    required this.memoryId,
    required this.title,
    required this.content,
    this.category,
    this.tags,
    required this.createdAt,
    this.imageUrl,
    this.sourceUrl,
    this.audioUrl,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.aiConfidence,
    this.isAiProcessing = false,
    this.authorName,
    this.authorAvatar,
    this.isOwnPost = true, // По умолчанию свой пост
    this.reactionsCount = 0,
    this.commentsCount = 0,
    this.sharesCount = 0,
    this.viewsCount = 0,
    this.isReacted = false,
  });

  @override
  State<MemoryCard> createState() => _MemoryCardState();
}

class _MemoryCardState extends State<MemoryCard> {
  bool _isExpanded = false;
  late int _reactionsCount;
  late int _commentsCount;
  late int _sharesCount;
  late int _viewsCount;
  late bool _isReacted;
  late final MemoryReactionsDataSource _reactionsDataSource;

  @override
  void initState() {
    super.initState();
    _reactionsCount = widget.reactionsCount;
    _commentsCount = widget.commentsCount;
    _sharesCount = widget.sharesCount;
    _viewsCount = widget.viewsCount;
    _isReacted = widget.isReacted;
    _reactionsDataSource = MemoryReactionsDataSource(DioClient());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppTheme.darkColor.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: widget.onTap,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header - User info
                Row(
                  children: [
                    // Avatar
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: widget.authorAvatar == null
                            ? AppTheme.primaryGradient
                            : null,
                      ),
                      child: widget.authorAvatar != null
                          ? ClipOval(
                              child: CachedNetworkImage(
                                imageUrl:
                                    widget.authorAvatar!.startsWith('/uploads')
                                    ? 'http://localhost:8000${widget.authorAvatar}'
                                    : widget.authorAvatar!,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Container(
                                  decoration: BoxDecoration(
                                    gradient: AppTheme.primaryGradient,
                                  ),
                                ),
                                errorWidget: (context, url, error) => Container(
                                  decoration: BoxDecoration(
                                    gradient: AppTheme.primaryGradient,
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Ionicons.person,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const Center(
                              child: Icon(
                                Ionicons.person,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                    ),
                    const SizedBox(width: 12),
                    // Name and date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.authorName ?? 'Вы',
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.darkColor,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            _formatDate(widget.createdAt),
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: AppTheme.darkColor.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Subscribe button (если не свой пост)
                    if (!widget.isOwnPost)
                      TextButton(
                        onPressed: () {
                          // TODO: Implement subscribe
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 6,
                          ),
                          backgroundColor: AppTheme.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Подписаться',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    // More button
                    IconButton(
                      icon: Icon(
                        Ionicons.ellipsis_horizontal,
                        color: AppTheme.darkColor.withOpacity(0.6),
                        size: 20,
                      ),
                      onPressed: () => _showOptionsMenu(context),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // Title and content
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.darkColor,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.content.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        widget.content,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: AppTheme.darkColor.withOpacity(0.8),
                          height: 1.5,
                        ),
                        maxLines: _isExpanded ? null : 3,
                        overflow: _isExpanded ? null : TextOverflow.ellipsis,
                      ),
                      // "Читать всё" button
                      if (widget.content.length > 150)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: Text(
                              _isExpanded ? 'Скрыть' : 'Читать всё',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ],
                ),

                // Ссылка
                if (widget.sourceUrl != null && widget.sourceUrl!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () async {
                      final url = widget.sourceUrl!;
                      final uri = Uri.parse(url.startsWith('http') ? url : 'https://$url');
                      if (await canLaunchUrl(uri)) {
                        await launchUrl(uri, mode: LaunchMode.externalApplication);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              gradient: AppTheme.primaryGradient,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Ionicons.link_outline,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Ссылка',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.darkColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  widget.sourceUrl!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: AppTheme.primaryColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Ionicons.open_outline,
                            color: AppTheme.primaryColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],

                // Аудио
                if (widget.audioUrl != null && widget.audioUrl!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppTheme.darkColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: AudioPlayerWidget(
                      audioPath: _getFullUrl(widget.audioUrl!),
                      onDelete: null, // Не показываем кнопку удаления в карточке
                    ),
                  ),
                ],

                // Image
                if (widget.imageUrl != null && widget.imageUrl!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: _getFullUrl(widget.imageUrl!),
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 200,
                        color: AppTheme.darkColor.withOpacity(0.05),
                        child: const Center(
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 200,
                        color: AppTheme.darkColor.withOpacity(0.05),
                        child: Center(
                          child: Icon(
                            Ionicons.image_outline,
                            color: AppTheme.darkColor.withOpacity(0.3),
                            size: 48,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],

                // Tags and category
                if ((widget.tags != null && widget.tags!.isNotEmpty) ||
                    widget.category != null ||
                    widget.aiConfidence != null) ...[
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      // Category
                      if (widget.category != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                _getCategoryIcon(widget.category!),
                                size: 14,
                                color: AppTheme.primaryColor,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.category!,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppTheme.darkColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      // AI confidence
                      if (widget.aiConfidence != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.amber.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Ionicons.star,
                                size: 14,
                                color: Colors.amber,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                (widget.aiConfidence! * 5).toStringAsFixed(1),
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppTheme.darkColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      // Tags
                      if (widget.tags != null)
                        ...widget.tags!.take(3).map((tag) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppTheme.darkColor.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '#$tag',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkColor.withOpacity(0.7),
                              ),
                            ),
                          );
                        }),
                    ],
                  ),
                ],

                // Bottom actions
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Row(
                    children: [
                      _buildActionButton(
                        icon:
                            _isReacted ? Ionicons.heart : Ionicons.heart_outline,
                        label: _formatCount(_reactionsCount),
                        onTap: _toggleLike,
                        isActive: _isReacted,
                      ),
                      const SizedBox(width: 20),
                      _buildActionButton(
                        icon: Ionicons.chatbubble_outline,
                        label: _formatCount(_commentsCount),
                        onTap: _openComments,
                      ),
                      const SizedBox(width: 20),
                      _buildActionButton(
                        icon: Ionicons.paper_plane_outline,
                        label:
                            _sharesCount > 0 ? _formatCount(_sharesCount) : '',
                        onTap: _shareMemory,
                      ),
                      const Spacer(),
                      if (_viewsCount > 0)
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              _formatCount(_viewsCount),
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: AppTheme.darkColor.withOpacity(0.6),
                              ),
                            ),
                            const SizedBox(width: 4),
                            Icon(
                              Ionicons.eye_outline,
                              size: 16,
                              color: AppTheme.darkColor.withOpacity(0.6),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isActive
                  ? AppTheme.primaryColor
                  : AppTheme.darkColor.withOpacity(0.7),
            ),
            if (label.isNotEmpty) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isActive
                      ? AppTheme.primaryColor
                      : AppTheme.darkColor.withOpacity(0.7),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _toggleLike() async {
    try {
      // Оптимистичное обновление UI
      setState(() {
        if (_isReacted) {
          _isReacted = false;
          if (_reactionsCount > 0) _reactionsCount -= 1;
        } else {
          _isReacted = true;
          _reactionsCount += 1;
        }
      });

      ReactionsSummary summary;
      if (_isReacted) {
        summary = await _reactionsDataSource.addReaction(
          memoryId: widget.memoryId,
          reactionType: ReactionType.like,
        );
      } else {
        summary = await _reactionsDataSource.removeReaction(widget.memoryId);
      }

      if (!mounted) return;

      setState(() {
        _reactionsCount = summary.total;
        _isReacted = summary.userReaction == ReactionType.like;
      });
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Не удалось обновить реакцию: $e'),
        ),
      );
    }
  }

  void _openComments() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.8,
          minChildSize: 0.6,
          maxChildSize: 0.95,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: CommentsSection(
                memoryId: widget.memoryId,
                currentUserId:
                    '', // TODO: пробросить реальный ID пользователя для удаления своих комментариев
              ),
            );
          },
        );
      },
    );
  }

  void _shareMemory() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Функция \"поделиться\" скоро будет доступна'),
      ),
    );
  }

  String _formatCount(int count) {
    if (count == 0) return '';
    if (count < 1000) return count.toString();
    if (count < 1000000) return '${(count / 1000).toStringAsFixed(1)}K'.replaceAll('.0', '');
    return '${(count / 1000000).toStringAsFixed(1)}M'.replaceAll('.0', '');
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 36,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),

              // Report option
              if (!widget.isOwnPost)
                ListTile(
                  leading: Icon(
                    Ionicons.flag_outline,
                    color: Colors.red.withOpacity(0.9),
                  ),
                  title: Text(
                    'Пожаловаться на пост',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red.withOpacity(0.9),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _showReportDialog(context);
                  },
                ),

              // Own post options
              if (widget.isOwnPost) ...[
                ListTile(
                  leading: Icon(
                    Ionicons.create_outline,
                    color: Colors.white.withOpacity(0.9),
                  ),
                  title: Text(
                    'Редактировать',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    widget.onEdit?.call();
                  },
                ),
                ListTile(
                  leading: Icon(
                    Ionicons.trash_outline,
                    color: Colors.red.withOpacity(0.9),
                  ),
                  title: Text(
                    'Удалить',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.red.withOpacity(0.9),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    widget.onDelete?.call();
                  },
                ),
              ],

              // Cancel button
              Padding(
                padding: const EdgeInsets.all(16),
                child: SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.white.withOpacity(0.1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Отмена',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1C1C1E),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text(
          'Пожаловаться на пост',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: const Text(
          'Вы уверены, что хотите пожаловаться на этот пост?',
          style: TextStyle(color: Colors.white70, fontSize: 14),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Отмена',
              style: TextStyle(
                color: Colors.white.withOpacity(0.6),
                fontSize: 16,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              // TODO: Implement report functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Жалоба отправлена'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text(
              'Пожаловаться',
              style: TextStyle(
                color: Colors.red,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category.toLowerCase()) {
      case 'movies':
      case 'фильмы':
        return Ionicons.film_outline;
      case 'books':
      case 'книги':
        return Ionicons.book_outline;
      case 'music':
      case 'музыка':
        return Ionicons.musical_notes_outline;
      case 'travel':
      case 'путешествия':
        return Ionicons.airplane_outline;
      case 'food':
      case 'еда':
        return Ionicons.restaurant_outline;
      default:
        return Ionicons.bookmark_outline;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      if (difference.inHours == 0) {
        if (difference.inMinutes == 0) {
          return 'только что';
        }
        return '${difference.inMinutes} мин назад';
      }
      return '${difference.inHours} ч назад';
    } else if (difference.inDays == 1) {
      return 'вчера';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} дн назад';
    } else {
      return '${date.day} ${_getMonthName(date.month)}';
    }
  }

  String _getMonthName(int month) {
    const months = [
      'янв',
      'фев',
      'мар',
      'апр',
      'мая',
      'июн',
      'июл',
      'авг',
      'сен',
      'окт',
      'ноя',
      'дек',
    ];
    return months[month - 1];
  }

  String _getFullUrl(String url) {
    // Если URL уже полный (начинается с http), возвращаем как есть
    if (url.startsWith('http://') || url.startsWith('https://')) {
      return url;
    }
    // Если относительный путь, добавляем префикс localhost
    if (url.startsWith('/')) {
      return 'http://localhost:8000$url';
    }
    // Иначе возвращаем как есть
    return url;
  }
}
