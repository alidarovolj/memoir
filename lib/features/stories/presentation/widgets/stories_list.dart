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

class _StoriesListState extends State<StoriesList> {
  final Set<String> _viewedStoryIds = {};

  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return Container(
        height: 110,
        decoration: BoxDecoration(
          color: Colors.white,
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
        color: Colors.white,
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
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppTheme.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.primaryColor.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Ionicons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Добавить',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
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
          }).toList(),
        ],
      ),
    );
  }
}
