import 'package:flutter/material.dart';
import 'package:memoir/features/analytics/data/models/analytics_model.dart';
import 'package:intl/intl.dart';

class ActivityHeatmap extends StatelessWidget {
  final List<DayActivity> dailyActivities;

  const ActivityHeatmap({super.key, required this.dailyActivities});

  Color _getColorForActivity(int totalActivity) {
    if (totalActivity == 0) return Colors.white.withOpacity(0.1);
    if (totalActivity <= 2) return const Color(0xFFc6e48b).withOpacity(0.5);
    if (totalActivity <= 5) return const Color(0xFF7bc96f);
    if (totalActivity <= 10) return const Color(0xFF49af5d);
    return const Color(0xFF196127);
  }

  int _getTotalActivity(DayActivity activity) {
    return activity.memoriesCount +
        activity.tasksCompleted +
        (activity.timeTracked > 0 ? 1 : 0) +
        activity.storiesCreated;
  }

  @override
  Widget build(BuildContext context) {
    // Group by weeks
    final weeks = <List<DayActivity>>[];
    var currentWeek = <DayActivity>[];

    for (var activity in dailyActivities) {
      if (currentWeek.isEmpty) {
        // Start new week, add empty days if needed
        int weekday = activity.date.weekday;
        for (int i = 1; i < weekday; i++) {
          currentWeek.add(
            DayActivity(
              date: activity.date.subtract(Duration(days: weekday - i)),
              memoriesCount: 0,
              tasksCompleted: 0,
              timeTracked: 0,
              storiesCreated: 0,
            ),
          );
        }
      }

      currentWeek.add(activity);

      if (activity.date.weekday == 7 || activity == dailyActivities.last) {
        weeks.add(List.from(currentWeek));
        currentWeek.clear();
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
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
        margin: const EdgeInsets.all(1),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(44, 44, 44, 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Week day labels
          Row(
            children: [
              const SizedBox(width: 30),
              ...['Пн', 'Вт', 'Ср', 'Чт', 'Пт', 'Сб', 'Вс'].map(
                (day) => Expanded(
                  child: Center(
                    child: Text(
                      day,
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.6),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),

          // Heatmap grid
          ...weeks.asMap().entries.map((entry) {
            final weekIndex = entry.key;
            final week = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                children: [
                  // Week number
                  SizedBox(
                    width: 30,
                    child: Text(
                      'W${weekIndex + 1}',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white.withOpacity(0.4),
                      ),
                    ),
                  ),
                  // Days
                  ...week.map((activity) {
                    final totalActivity = _getTotalActivity(activity);
                    final color = _getColorForActivity(totalActivity);

                    return Expanded(
                      child: Tooltip(
                        message:
                            '${DateFormat('dd MMM').format(activity.date)}\n$totalActivity активностей',
                        child: Container(
                          height: 32,
                          margin: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Center(
                            child: Text(
                              '${activity.date.day}',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: totalActivity > 5
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.8),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          }),

          const SizedBox(height: 12),

          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Меньше',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
              const SizedBox(width: 8),
              ...[0, 2, 5, 10, 15].map((activity) {
                return Container(
                  width: 16,
                  height: 16,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: _getColorForActivity(activity),
                    borderRadius: BorderRadius.circular(4),
                  ),
                );
              }),
              const SizedBox(width: 8),
              Text(
                'Больше',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.white.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}
