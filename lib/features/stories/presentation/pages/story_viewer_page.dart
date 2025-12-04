import 'package:flutter/material.dart';
import 'package:memoir/features/stories/data/models/story_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ionicons/ionicons.dart';

class StoryViewerPage extends StatefulWidget {
  final List<StoryModel> stories;
  final int initialIndex;

  const StoryViewerPage({
    super.key,
    required this.stories,
    this.initialIndex = 0,
  });

  @override
  State<StoryViewerPage> createState() => _StoryViewerPageState();
}

class _StoryViewerPageState extends State<StoryViewerPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _progressController;
  int _currentIndex = 0;
  final Set<String> _viewedStoryIds = {}; // Отслеживаем просмотренные истории
  static const _storyDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);

    _progressController = AnimationController(
      vsync: this,
      duration: _storyDuration,
    );

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
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      _startStoryProgress();
    } else {
      // Все истории просмотрены
      // ignore: invalid_use_of_protected_member
      _viewedStoryIds.add(widget.stories[_currentIndex].id);
      Navigator.of(
        context,
      ).pop(_viewedStoryIds); // Возвращаем список просмотренных
    }
  }

  void _previousStory() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
      });
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
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
                        CircleAvatar(
                          radius: 20,
                          child: Text(
                            (widget.stories[_currentIndex].user?.username ??
                                    'U')[0]
                                .toUpperCase(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.stories[_currentIndex].user?.username ??
                                    'User',
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
                          onPressed: () =>
                              Navigator.of(context).pop(_viewedStoryIds),
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
}
