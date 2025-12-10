import 'package:flutter/material.dart';
import 'package:memoir/features/analytics/data/models/analytics_model.dart';

class CategoryChart extends StatelessWidget {
  final List<CategoryStats> categoryStats;

  const CategoryChart({super.key, required this.categoryStats});

  Color _getCategoryColor(int index) {
    final colors = [
      const Color(0xFF667EEA),
      const Color(0xFF48BB78),
      const Color(0xFFFF6B6B),
      const Color(0xFFFBD38D),
      const Color(0xFF9F7AEA),
      const Color(0xFF4299E1),
    ];
    return colors[index % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    if (categoryStats.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Center(child: Text('Нет данных по категориям')),
      );
    }

    // Sort by total activity (memories + tasks)
    final sortedStats = List<CategoryStats>.from(categoryStats);
    sortedStats.sort((a, b) {
      final totalA = a.memoriesCount + a.tasksCount;
      final totalB = b.memoriesCount + b.tasksCount;
      return totalB.compareTo(totalA);
    });

    // Take top 5
    final topStats = sortedStats.take(5).toList();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: topStats.asMap().entries.map((entry) {
          final index = entry.key;
          final stat = entry.value;
          final color = _getCategoryColor(index);
          final total = stat.memoriesCount + stat.tasksCount;

          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        stat.categoryName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      '$total',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Stack(
                  children: [
                    // Background bar
                    Container(
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    // Completion rate bar
                    FractionallySizedBox(
                      widthFactor: stat.completionRate / 100,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${stat.memoriesCount} воспоминаний · ${stat.tasksCount} задач',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.black.withOpacity(0.5),
                      ),
                    ),
                    Text(
                      '${stat.completionRate.toStringAsFixed(0)}%',
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: color,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
