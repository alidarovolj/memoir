import 'package:flutter/material.dart';
import 'package:memoir/features/stories/data/models/story_model.dart';
import 'package:memoir/features/stories/presentation/widgets/story_circle.dart';
import 'package:memoir/features/stories/presentation/pages/story_viewer_page.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'dart:math' as math;

class StoriesList extends StatefulWidget {
  final List<StoryModel> stories;
  final bool isLoading;
  final VoidCallback onAddStory;
  final Function(StoryModel) onStoryTap;

  const StoriesList({
    super.key,
    required this.stories,
    this.isLoading = false,
    required this.onAddStory,
    required this.onStoryTap,
  });

  @override
  State<StoriesList> createState() => _StoriesListState();
}

class _StoriesListState extends State<StoriesList>
    with SingleTickerProviderStateMixin {
  final Set<String> _viewedStoryIds = {};
  late AnimationController _rotationController;

  @override
  void initState() {
    super.initState();
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 15),
    )..repeat();
  }

  @override
  void dispose() {
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Container(
        height: 110,
        decoration: BoxDecoration(),
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    // Группируем истории по пользователям
    final Map<String, List<StoryModel>> storiesByUser = {};
    for (var story in widget.stories) {
      // ignore: invalid_use_of_protected_member
      final userId = story.user_id;
      if (!storiesByUser.containsKey(userId)) {
        storiesByUser[userId] = [];
      }
      storiesByUser[userId]!.add(story);
    }

    // Сортируем истории внутри каждой группы по дате создания (новые первыми)
    for (var userStories in storiesByUser.values) {
      userStories.sort((a, b) => b.created_at.compareTo(a.created_at));
    }

    return Container(
      height: 112,
      decoration: BoxDecoration(color: AppTheme.pageBackgroundColor),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        scrollDirection: Axis.horizontal,
        children: [
          // "Добавить историю" кнопка
          GestureDetector(
            onTap: widget.onAddStory,
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppTheme.whiteColor,
                    ),
                    child: Stack(
                      children: [
                        // Вращающаяся пунктирная обводка
                        RotationTransition(
                          turns: _rotationController,
                          child: CustomPaint(
                            size: const Size(68, 68),
                            painter: DashedCirclePainter(),
                          ),
                        ),
                        // Статичная иконка по центру
                        const Center(
                          child: Icon(
                            Ionicons.add,
                            color: AppTheme.primaryColor,
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Добавить',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppTheme.darkColor.withOpacity(0.7),
                      letterSpacing: 0.2,
                      height: 1.2,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
          ),

          // Список историй (сгруппированных по пользователям)
          ...storiesByUser.entries.toList().asMap().entries.map((mapEntry) {
            final groupIndex = mapEntry.key;
            final userStories = mapEntry.value.value;
            final firstStory = userStories.first;

            // Проверяем, все ли истории пользователя просмотрены
            final allViewed = userStories.every(
              (s) => _viewedStoryIds.contains(s.id),
            );

            // Определяем изображение: приоритет у изображения из памяти, затем аватар пользователя
            String? storyImageUrl;
            if (firstStory.memory?.image_url != null) {
              final memoryImageUrl = firstStory.memory!.image_url!;
              storyImageUrl =
                  memoryImageUrl.startsWith('/uploads') ||
                      memoryImageUrl.startsWith('http')
                  ? (memoryImageUrl.startsWith('/uploads')
                        ? 'http://localhost:8000$memoryImageUrl'
                        : memoryImageUrl)
                  : null;
            }

            if (storyImageUrl == null && firstStory.user?.avatar_url != null) {
              final avatarUrl = firstStory.user!.avatar_url!;
              storyImageUrl = avatarUrl.startsWith('/uploads')
                  ? 'http://localhost:8000$avatarUrl'
                  : avatarUrl;
            }

            return StoryCircle(
              imageUrl: storyImageUrl,
              username: _getUserDisplayName(firstStory.user),
              isViewed: allViewed,
              storiesCount: userStories.length,
              onTap: () async {
                // Собираем все группы историй в правильном порядке
                final allGroups = storiesByUser.values.toList();

                // Открываем viewer с текущей группы
                final viewedIds = await _openStoriesFromGroup(
                  allGroups,
                  groupIndex,
                );

                // Обновляем список просмотренных
                if (viewedIds != null) {
                  setState(() {
                    _viewedStoryIds.addAll(viewedIds);
                  });
                }
              },
            );
          }),
        ],
      ),
    );
  }

  // Открываем истории начиная с определенной группы
  Future<Set<String>?> _openStoriesFromGroup(
    List<List<StoryModel>> allGroups,
    int startGroupIndex,
  ) async {
    return await Navigator.of(context).push<Set<String>>(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _GroupedStoriesViewer(
              allGroups: allGroups,
              startGroupIndex: startGroupIndex,
            ),
        transitionDuration: const Duration(milliseconds: 250),
        reverseTransitionDuration: const Duration(milliseconds: 250),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          // Анимация fade + scale при открытии и закрытии
          // При открытии: animation идет от 0.0 до 1.0
          // При закрытии: animation идет от 1.0 до 0.0 (reverse)
          
          final fadeAnimation = Tween<double>(
            begin: 0.0,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ));
          
          final scaleAnimation = Tween<double>(
            begin: 0.95,
            end: 1.0,
          ).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          ));
          
          return FadeTransition(
            opacity: fadeAnimation,
            child: ScaleTransition(
              scale: scaleAnimation,
              alignment: Alignment.center,
              child: child,
            ),
          );
        },
        opaque: false,
      ),
    );
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
}

class DashedCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryColor.withOpacity(0.8)
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 1;

    // Рисуем пунктирный круг
    const dashWidth = 4.0;
    const dashSpace = 4.0;
    const totalDashes = 20.0;

    for (var i = 0; i < totalDashes; i++) {
      final startAngle = (i * 2 * 3.14159 / totalDashes);
      final endAngle = ((i + 0.5) * 2 * 3.14159 / totalDashes);

      final path = Path()
        ..addArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          endAngle - startAngle,
        );

      canvas.drawPath(path, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

// Виджет для просмотра сгруппированных историй с кубической анимацией
class _GroupedStoriesViewer extends StatefulWidget {
  final List<List<StoryModel>> allGroups;
  final int startGroupIndex;

  const _GroupedStoriesViewer({
    required this.allGroups,
    required this.startGroupIndex,
  });

  @override
  State<_GroupedStoriesViewer> createState() => _GroupedStoriesViewerState();
}

class _GroupedStoriesViewerState extends State<_GroupedStoriesViewer> {
  late PageController _pageController;
  final Set<String> _allViewedIds = {};
  int _currentGroupIndex = 0;

  @override
  void initState() {
    super.initState();
    _currentGroupIndex = widget.startGroupIndex;
    _pageController = PageController(initialPage: widget.startGroupIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onGroupCompleted(Set<String> viewedIds, bool isLastStory) {
    _allViewedIds.addAll(viewedIds);

    if (isLastStory) {
      // Автоматически переходим к следующей группе
      if (_currentGroupIndex < widget.allGroups.length - 1) {
        setState(() {
          _currentGroupIndex++;
        });
        _pageController.animateToPage(
          _currentGroupIndex,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOutCubic,
        );
      } else {
        // Это была последняя группа - закрываем viewer
        Navigator.of(context).pop(_allViewedIds);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: _pageController,
      itemCount: widget.allGroups.length,
      physics: const BouncingScrollPhysics(),
      onPageChanged: (index) {
        setState(() {
          _currentGroupIndex = index;
        });
      },
      itemBuilder: (context, index) {
        final groupStories = widget.allGroups[index];
        return AnimatedBuilder(
          animation: _pageController,
          builder: (context, child) {
            double value = 0.0;
            if (_pageController.position.haveDimensions) {
              value = index.toDouble() - (_pageController.page ?? 0);
            }

            // Cube rotation effect
            final double rotationY = value * math.pi / 2;
            final double scale = 1.0 - (value.abs() * 0.3);

            return Center(
              child: Transform(
                transform: Matrix4.identity()
                  ..setEntry(3, 2, 0.002) // perspective
                  ..rotateY(rotationY)
                  ..scale(scale),
                alignment: value > 0
                    ? Alignment.centerLeft
                    : Alignment.centerRight,
                child: child,
              ),
            );
          },
          child: StoryViewerPage(
            stories: groupStories,
            onStoriesCompleted: (viewedIds) {
              _onGroupCompleted(viewedIds, true);
            },
            onEarlyExit: (viewedIds) {
              _allViewedIds.addAll(viewedIds);
              Navigator.of(context).pop(_allViewedIds);
            },
          ),
        );
      },
    );
  }
}
