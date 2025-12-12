import 'package:flutter/material.dart';
import 'package:memoir/features/stories/data/models/story_model.dart';
import 'package:memoir/features/stories/presentation/widgets/story_circle.dart';
import 'package:memoir/features/stories/presentation/pages/story_viewer_page.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';

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
                  SizedBox(
                    width: 68,
                    height: 68,
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
                        Center(
                          child: Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.transparent,
                            ),
                            child: const Icon(
                              Ionicons.add,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ],
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
          ...storiesByUser.entries.map((entry) {
            final userStories = entry.value;
            final firstStory = userStories.first;

            // Проверяем, все ли истории пользователя просмотрены
            final allViewed = userStories.every(
              (s) => _viewedStoryIds.contains(s.id),
            );

            return StoryCircle(
              // ignore: invalid_use_of_protected_member
              imageUrl:
                  firstStory.memory?.image_url ??
                  firstStory.memory?.backdrop_url,
              username: firstStory.user?.username ?? 'User',
              isViewed: allViewed,
              storiesCount: userStories.length,
              onTap: () async {
                // Передаем все истории пользователя
                final viewedIds = await Navigator.of(context).push<Set<String>>(
                  MaterialPageRoute(
                    builder: (context) => StoryViewerPage(stories: userStories),
                  ),
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
