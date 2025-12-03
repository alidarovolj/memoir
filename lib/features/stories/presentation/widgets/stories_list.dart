import 'package:flutter/material.dart';
import 'package:memoir/features/stories/data/models/story_model.dart';
import 'package:memoir/features/stories/presentation/widgets/story_circle.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/theme/app_theme.dart';

class StoriesList extends StatelessWidget {
  final List<StoryModel> stories;
  final VoidCallback onAddStory;
  final Function(StoryModel) onStoryTap;

  const StoriesList({
    super.key,
    required this.stories,
    required this.onAddStory,
    required this.onStoryTap,
  });

  @override
  Widget build(BuildContext context) {
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
            onTap: onAddStory,
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 12),
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

          // Список историй
          ...stories.map((story) {
            return StoryCircle(
              // ignore: invalid_use_of_protected_member
              imageUrl: story.memory?.image_url ?? story.memory?.backdrop_url,
              username: story.user?.username ?? 'User',
              isViewed: false, // TODO: implement viewed tracking
              onTap: () => onStoryTap(story),
            );
          }).toList(),
        ],
      ),
    );
  }
}
