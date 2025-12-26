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
        decoration: BoxDecoration(
          color: AppTheme.headerBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }

    if (widget.stories.isEmpty) {
      return const SizedBox.shrink();
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

    return Container(
      height: 110,
      decoration: BoxDecoration(
        color: AppTheme.headerBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        scrollDirection: Axis.horizontal,
        children: [
          // "Добавить историю" кнопка
          GestureDetector(
            onTap: widget.onAddStory,
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 6),
              child: Column(
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromRGBO(255, 255, 255, 0.2),
                          Color.fromRGBO(233, 233, 233, 0.2),
                          Color.fromRGBO(242, 242, 242, 0),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(1), // Толщина границы
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromRGBO(44, 44, 44, 1),
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
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Добавить',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
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

            return StoryCircle(
              // ignore: invalid_use_of_protected_member
              imageUrl:
                  firstStory.user?.avatar_url != null &&
                      firstStory.user!.avatar_url!.startsWith('/uploads')
                  ? 'http://localhost:8000${firstStory.user!.avatar_url}'
                  : firstStory.user?.avatar_url,
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
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return child;
        },
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
      ..color = AppTheme.primaryColor
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
