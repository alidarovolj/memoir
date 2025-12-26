import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/features/analytics/presentation/widgets/stats_card.dart';

class HeaderStats extends StatelessWidget {
  final int totalMemories;
  final int totalTasksCompleted;

  const HeaderStats({
    super.key,
    required this.totalMemories,
    required this.totalTasksCompleted,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatsCard(
            icon: Ionicons.albums_outline,
            value: '$totalMemories',
            label: 'Воспоминаний',
            color: const Color(0xFF667EEA),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatsCard(
            icon: Ionicons.checkmark_circle_outline,
            value: '$totalTasksCompleted',
            label: 'Задач',
            color: const Color(0xFF48BB78),
          ),
        ),
      ],
    );
  }
}
