import 'package:flutter/material.dart';
import 'package:memoir/features/stories/data/models/story_model.dart';
import 'package:memoir/features/stories/data/datasources/story_remote_datasource.dart';
import 'package:memoir/core/network/dio_client.dart';
import 'package:memoir/core/utils/snackbar_utils.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ionicons/ionicons.dart';
import 'dart:math' as math;

class StoryViewerPage extends StatefulWidget {
  final List<StoryModel> stories;
  final int initialIndex;
  final Function(Set<String>)? onStoriesCompleted;
  final Function(Set<String>)? onEarlyExit;

  const StoryViewerPage({
    super.key,
    required this.stories,
    this.initialIndex = 0,
    this.onStoriesCompleted,
    this.onEarlyExit,
  });

  @override
  State<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends State<StoryViewerPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  late StoryRemoteDataSource _dataSource;
  int _currentIndex = 0;
  final Set<String> _viewedStoryIds = {}; // Отслеживаем просмотренные истории
  static const _storyDuration = Duration(seconds: 5);

  // Track local state for social features
  Map<String, bool> _localLikeStates = {};
  Map<String, int> _localLikeCounts = {};
  Map<String, int> _localCommentCounts = {};

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    _dataSource = StoryRemoteDataSourceImpl(dio: DioClient.instance);

    _progressController = AnimationController(
      vsync: this,
      duration: _storyDuration,
    );

    // Initialize local state from widget stories
    for (var story in widget.stories) {
      _localLikeStates[story.id] = story.is_liked;
      _localLikeCounts[story.id] = story.likes_count;
      _localCommentCounts[story.id] = story.comments_count;
    }

    // Запускаем автоматическое пролистывание
    _startStoryProgress();

    // Слушаем завершение анимации
    _progressController.addStatusListener(_onProgressComplete);
  }

  void _startStoryProgress() {
    _progressController.forward(from: 0.0);
  }

  void _onProgressComplete(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _nextStory();
    }
  }

  void _nextStory() {
    if (_currentIndex < widget.stories.length - 1) {
      // Отмечаем текущую историю как просмотренную
      setState(() {
        // ignore: invalid_use_of_protected_member
        _viewedStoryIds.add(widget.stories[_currentIndex].id);
        _currentIndex++;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic, // Кубическая анимация
      );
      _startStoryProgress();
    } else {
      // Все истории просмотрены
      // ignore: invalid_use_of_protected_member
      _viewedStoryIds.add(widget.stories[_currentIndex].id);

      // Если есть коллбэк для завершения всех историй, вызываем его
      if (widget.onStoriesCompleted != null) {
        widget.onStoriesCompleted!(_viewedStoryIds);
      } else {
        // Иначе просто закрываем страницу
        Navigator.of(context).pop(_viewedStoryIds);
      }
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOutCubic, // Кубическая анимация
      );
      _startStoryProgress();
    }
  }

  void _pauseStory() {
    _progressController.stop();
  }

  void _resumeStory() {
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.removeStatusListener(_onProgressComplete);
    _progressController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // ==================== SOCIAL ACTIONS ====================

  Future<void> _toggleLike() async {
    final story = widget.stories[_currentIndex];
    final currentLikedState = _localLikeStates[story.id] ?? story.is_liked;

    // Optimistic update (без паузы истории - лайк быстрый)
    setState(() {
      _localLikeStates[story.id] = !currentLikedState;
      _localLikeCounts[story.id] =
          (_localLikeCounts[story.id] ?? story.likes_count) +
          (currentLikedState ? -1 : 1);
    });

    try {
      if (currentLikedState) {
        await _dataSource.unlikeStory(story.id);
      } else {
        await _dataSource.likeStory(story.id);
      }
    } catch (e) {
      // Revert on error
      setState(() {
        _localLikeStates[story.id] = currentLikedState;
        _localLikeCounts[story.id] = story.likes_count;
      });
      if (mounted) {
        SnackBarUtils.showError(context, 'Ошибка при обновлении лайка');
      }
    }
  }

  Future<void> _showComments() async {
    _pauseStory();
    final story = widget.stories[_currentIndex];

    final newCommentsCount = await showModalBottomSheet<int>(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      backgroundColor: Colors.transparent,
      builder: (context) =>
          _CommentsBottomSheet(storyId: story.id, dataSource: _dataSource),
    );

    // Обновляем счетчик комментариев, если был изменен
    if (newCommentsCount != null && mounted) {
      setState(() {
        _localCommentCounts[story.id] = newCommentsCount;
      });
    }

    // Возобновляем только если еще смонтирован
    if (mounted) {
      _resumeStory();
    }
  }

  Future<void> _showShareOptions() async {
    _pauseStory();
    final story = widget.stories[_currentIndex];

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1C1C1E),
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 36,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),

              // Title
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                child: Text(
                  'Поделиться историей',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Share options
              _buildShareOption(
                icon: Ionicons.copy_outline,
                title: 'Копировать ссылку',
                onTap: () {
                  // TODO: Implement copy link
                  Navigator.pop(context);
                  if (mounted) {
                    SnackBarUtils.showSuccess(context, 'Ссылка скопирована');
                  }
                },
              ),

              _buildShareOption(
                icon: Ionicons.paper_plane_outline,
                title: 'Отправить в сообщении',
                onTap: () {
                  Navigator.pop(context);
                  // TODO: Implement send to user
                  if (mounted) {
                    SnackBarUtils.showInfo(context, 'Функция в разработке');
                  }
                },
              ),

              const SizedBox(height: 8),

              // Cancel button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
    ).then((_) {
      if (mounted) {
        _resumeStory();
      }
    });
  }

  Widget _buildShareOption({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: Colors.white.withOpacity(0.9), size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.9),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Icon(
              Ionicons.chevron_forward,
              color: Colors.white.withOpacity(0.3),
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        // Пауза при долгом нажатии
        onLongPressStart: (_) => _pauseStory(),
        onLongPressEnd: (_) => _resumeStory(),
        // Навигация по тапам
        onTapDown: (details) {
          final width = MediaQuery.of(context).size.width;
          if (details.localPosition.dx < width / 3) {
            // Тап слева - предыдущая история
            _previousStory();
          } else if (details.localPosition.dx > width * 2 / 3) {
            // Тап справа - следующая история
            _nextStory();
          }
        },
        child: Stack(
          children: [
            // Stories PageView
            PageView.builder(
              controller: _pageController,
              itemCount: widget.stories.length,
              physics:
                  const NeverScrollableScrollPhysics(), // Отключаем свайп, только тапы
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final story = widget.stories[index];
                return _buildStoryContent(story);
              },
            ),

            // Bottom action bar (Social buttons)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.7),
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      // Like button
                      _buildActionButton(
                        icon:
                            _localLikeStates[widget
                                    .stories[_currentIndex]
                                    .id] ??
                                widget.stories[_currentIndex].is_liked
                            ? Ionicons.heart
                            : Ionicons.heart_outline,
                        label:
                            '${_localLikeCounts[widget.stories[_currentIndex].id] ?? widget.stories[_currentIndex].likes_count}',
                        color:
                            _localLikeStates[widget
                                    .stories[_currentIndex]
                                    .id] ??
                                widget.stories[_currentIndex].is_liked
                            ? Colors.red
                            : Colors.white,
                        onTap: _toggleLike,
                      ),

                      // Comment button
                      _buildActionButton(
                        icon: Ionicons.chatbubble_outline,
                        label:
                            '${_localCommentCounts[widget.stories[_currentIndex].id] ?? widget.stories[_currentIndex].comments_count}',
                        color: Colors.white,
                        onTap: _showComments,
                      ),

                      // Share button
                      _buildActionButton(
                        icon: Ionicons.paper_plane_outline,
                        label: '${widget.stories[_currentIndex].shares_count}',
                        color: Colors.white,
                        onTap: _showShareOptions,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Top bar с прогрессом
            SafeArea(
              child: Column(
                children: [
                  // Progress indicators
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: List.generate(
                        widget.stories.length,
                        (index) => Expanded(
                          child: Container(
                            height: 3,
                            margin: const EdgeInsets.symmetric(horizontal: 2),
                            child: AnimatedBuilder(
                              animation: _progressController,
                              builder: (context, child) {
                                double progress = 0.0;

                                if (index < _currentIndex) {
                                  // Просмотренные истории - полный прогресс
                                  progress = 1.0;
                                } else if (index == _currentIndex) {
                                  // Текущая история - анимированный прогресс
                                  progress = _progressController.value;
                                } else {
                                  // Будущие истории - пустой прогресс
                                  progress = 0.0;
                                }

                                return LinearProgressIndicator(
                                  value: progress,
                                  backgroundColor: Colors.white.withOpacity(
                                    0.3,
                                  ),
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                  minHeight: 3,
                                  borderRadius: BorderRadius.circular(2),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // User info
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        // Avatar or initial
                        widget.stories[_currentIndex].user?.avatar_url != null
                            ? CircleAvatar(
                                radius: 20,
                                backgroundImage: CachedNetworkImageProvider(
                                  widget
                                          .stories[_currentIndex]
                                          .user!
                                          .avatar_url!
                                          .startsWith('/uploads')
                                      ? 'http://localhost:8000${widget.stories[_currentIndex].user!.avatar_url}'
                                      : widget
                                            .stories[_currentIndex]
                                            .user!
                                            .avatar_url!,
                                ),
                              )
                            : CircleAvatar(
                                radius: 20,
                                child: Text(
                                  _getUserDisplayName(
                                    widget.stories[_currentIndex].user,
                                  )[0].toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getUserDisplayName(
                                  widget.stories[_currentIndex].user,
                                ),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                _formatTime(
                                  // ignore: invalid_use_of_protected_member
                                  widget.stories[_currentIndex].created_at,
                                ),
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Ionicons.close, color: Colors.white),
                          onPressed: () {
                            if (widget.onEarlyExit != null) {
                              widget.onEarlyExit!(_viewedStoryIds);
                            } else {
                              Navigator.of(context).pop(_viewedStoryIds);
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStoryContent(StoryModel story) {
    final memory = story.memory;
    if (memory == null) {
      return const Center(
        child: Text('Нет данных', style: TextStyle(color: Colors.white)),
      );
    }

    return Container(
      color: Colors.black,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image
          // ignore: invalid_use_of_protected_member
          if (memory.image_url != null || memory.backdrop_url != null)
            Expanded(
              flex: 2,
              child: CachedNetworkImage(
                // ignore: invalid_use_of_protected_member
                imageUrl: memory.backdrop_url ?? memory.image_url!,
                fit: BoxFit.contain,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ),
                errorWidget: (context, url, error) => const Icon(
                  Ionicons.image_outline,
                  color: Colors.white,
                  size: 50,
                ),
              ),
            ),

          // Content
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      memory.title ?? 'Без заголовка',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      memory.content ?? '',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 14,
                        height: 1.5,
                      ),
                      maxLines: 6,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'только что';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} мин назад';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ч назад';
    } else {
      return '${difference.inDays} д назад';
    }
  }

  String _getUserDisplayName(StoryUserModel? user) {
    if (user == null) return 'User';

    // Если есть имя и фамилия, используем их
    if (user.first_name != null && user.first_name!.isNotEmpty) {
      if (user.last_name != null && user.last_name!.isNotEmpty) {
        return '${user.first_name} ${user.last_name}';
      }
      return user.first_name!;
    }

    // Если нет имени, используем username
    return user.username ?? 'User';
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// Comments Bottom Sheet
class _CommentsBottomSheet extends StatefulWidget {
  final String storyId;
  final StoryRemoteDataSource dataSource;

  const _CommentsBottomSheet({required this.storyId, required this.dataSource});

  @override
  State<_CommentsBottomSheet> createState() => _CommentsBottomSheetState();
}

class _CommentsBottomSheetState extends State<_CommentsBottomSheet> {
  final TextEditingController _commentController = TextEditingController();
  final List<dynamic> _comments = [];
  bool _isLoading = true;
  bool _isSending = false;
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _loadComments();
    _commentController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _commentController.removeListener(_onTextChanged);
    _commentController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final hasText = _commentController.text.trim().isNotEmpty;
    if (hasText != _hasText) {
      setState(() {
        _hasText = hasText;
      });
    }
  }

  Future<void> _loadComments() async {
    try {
      final result = await widget.dataSource.getStoryComments(widget.storyId);
      setState(() {
        _comments.clear();
        _comments.addAll(result.items);
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      if (mounted) {
        SnackBarUtils.showError(context, 'Ошибка загрузки комментариев');
      }
    }
  }

  Future<void> _sendComment() async {
    if (_commentController.text.trim().isEmpty) return;

    setState(() => _isSending = true);

    try {
      final newComment = await widget.dataSource.createComment(
        widget.storyId,
        _commentController.text.trim(),
      );

      setState(() {
        _comments.add(newComment);
        _commentController.clear();
        _isSending = false;
      });
    } catch (e) {
      setState(() => _isSending = false);
      if (mounted) {
        SnackBarUtils.showError(context, 'Ошибка отправки комментария');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Возвращаем количество комментариев при закрытии
        Navigator.of(context).pop(_comments.length);
        return false;
      },
      child: DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return Container(
            decoration: const BoxDecoration(
              color: Color(0xFF1C1C1E), // Instagram dark theme
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Column(
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

                // Title with count
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Комментарии',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                      if (_comments.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '${_comments.length}',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.white.withOpacity(0.7),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Comments list
                Expanded(
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : _comments.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Ionicons.chatbubble_ellipses_outline,
                                size: 64,
                                color: Colors.white.withOpacity(0.2),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Нет комментариев',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Начните обсуждение',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.4),
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.separated(
                          controller: scrollController,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          itemCount: _comments.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 1,
                            thickness: 0.5,
                            color: Colors.white.withOpacity(0.05),
                            indent: 68,
                          ),
                          itemBuilder: (context, index) {
                            final comment = _comments[index];
                            return _buildCommentItem(comment);
                          },
                        ),
                ),

                // Input field - Instagram style
                Container(
                  padding: EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                    bottom: MediaQuery.of(context).viewInsets.bottom > 0
                        ? 8
                        : MediaQuery.of(context).padding.bottom + 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1C1C1E),
                    border: Border(
                      top: BorderSide(
                        color: Colors.white.withOpacity(0.1),
                        width: 0.5,
                      ),
                    ),
                  ),
                  child: SafeArea(
                    top: false,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Avatar
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppTheme.primaryGradient,
                          ),
                          child: const Center(
                            child: Icon(
                              Ionicons.person,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Input field
                        Expanded(
                          child: Container(
                            constraints: const BoxConstraints(
                              minHeight: 36,
                              maxHeight: 100,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: Colors.white.withOpacity(0.15),
                                width: 1,
                              ),
                            ),
                            child: TextField(
                              controller: _commentController,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                height: 1.4,
                              ),
                              decoration: InputDecoration(
                                hintText: 'Добавьте комментарий...',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 15,
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 8,
                                ),
                              ),
                              maxLines: null,
                              textInputAction: TextInputAction.send,
                              onSubmitted: (_) => _sendComment(),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        // Send button
                        GestureDetector(
                          onTap: _isSending || !_hasText ? null : _sendComment,
                          child: Container(
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                            child: _isSending
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Color(0xFF0095F6), // Instagram blue
                                      ),
                                    ),
                                  )
                                : Icon(
                                    Ionicons.send,
                                    color: _hasText
                                        ? const Color(0xFF0095F6)
                                        : Colors.white.withOpacity(0.3),
                                    size: 24,
                                  ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCommentItem(dynamic comment) {
    final user = comment.user;
    final userName = user != null
        ? (user.first_name != null && user.first_name!.isNotEmpty
              ? '${user.first_name} ${user.last_name ?? ''}'.trim()
              : user.username ?? 'User')
        : 'User';

    final avatarUrl = user?.avatar_url;
    final hasAvatar = avatarUrl != null && avatarUrl.isNotEmpty;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: hasAvatar ? null : AppTheme.primaryGradient,
            ),
            child: hasAvatar
                ? ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: avatarUrl.startsWith('/uploads')
                          ? 'http://localhost:8000$avatarUrl'
                          : avatarUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                        ),
                        child: Center(
                          child: Text(
                            userName[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          gradient: AppTheme.primaryGradient,
                        ),
                        child: Center(
                          child: Text(
                            userName[0].toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Center(
                    child: Text(
                      userName[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
          ),
          const SizedBox(width: 12),
          // Comment content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Username and comment
                RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.4,
                      color: Colors.white,
                    ),
                    children: [
                      TextSpan(
                        text: userName,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      const TextSpan(text: '  '),
                      TextSpan(
                        text: comment.content ?? '',
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.9),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                // Time and reply button
                Row(
                  children: [
                    if (comment.created_at != null)
                      Text(
                        _formatCommentTime(comment.created_at),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    const SizedBox(width: 16),
                    // Reply button (placeholder for future feature)
                    GestureDetector(
                      onTap: () {
                        // TODO: Implement reply functionality
                      },
                      child: Text(
                        'Ответить',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Like button (optional - for future)
          Padding(
            padding: const EdgeInsets.only(left: 12, top: 4),
            child: Icon(
              Ionicons.heart_outline,
              size: 14,
              color: Colors.white.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }

  String _formatCommentTime(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inMinutes < 1) {
      return 'только что';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}м';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}ч';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}д';
    } else {
      return '${difference.inDays ~/ 7}н';
    }
  }
}
