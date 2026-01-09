import 'package:flutter/material.dart';
import 'package:memoir/core/theme/app_theme.dart';
import 'package:memoir/features/memories/data/models/memory_reactions_model.dart';

class ReactionsBar extends StatelessWidget {
  final ReactionsSummary summary;
  final Function(ReactionType) onReactionTap;
  final VoidCallback onReactionRemove;

  const ReactionsBar({
    super.key,
    required this.summary,
    required this.onReactionTap,
    required this.onReactionRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildReactionButton(
          emoji: '❤️',
          type: ReactionType.like,
          count: summary.like,
        ),
        const SizedBox(width: 8),
        _buildReactionButton(
          emoji: '😍',
          type: ReactionType.love,
          count: summary.love,
        ),
        const SizedBox(width: 8),
        _buildReactionButton(
          emoji: '🔥',
          type: ReactionType.fire,
          count: summary.fire,
        ),
        const SizedBox(width: 8),
        _buildReactionButton(
          emoji: '⭐',
          type: ReactionType.star,
          count: summary.star,
        ),
        const SizedBox(width: 8),
        _buildReactionButton(
          emoji: '🎉',
          type: ReactionType.celebrate,
          count: summary.celebrate,
        ),
        const SizedBox(width: 8),
        _buildReactionButton(
          emoji: '🤔',
          type: ReactionType.thinking,
          count: summary.thinking,
        ),
      ],
    );
  }

  Widget _buildReactionButton({
    required String emoji,
    required ReactionType type,
    required int count,
  }) {
    final isActive = summary.userReaction == type;

    return GestureDetector(
      onTap: () {
        if (isActive) {
          onReactionRemove();
        } else {
          onReactionTap(type);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isActive
              ? AppTheme.primaryColor.withOpacity(0.2)
              : Colors.white.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? AppTheme.primaryColor
                : Colors.white.withOpacity(0.2),
            width: isActive ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            if (count > 0) ...[
              const SizedBox(width: 4),
              Text(
                '$count',
                style: TextStyle(
                  color: isActive ? AppTheme.primaryColor : Colors.white70,
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
