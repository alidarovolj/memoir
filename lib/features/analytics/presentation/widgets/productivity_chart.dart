import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:memoir/features/analytics/data/models/analytics_model.dart';
import 'package:memoir/core/theme/app_theme.dart';

class ProductivityChart extends StatelessWidget {
  final List<ProductivityTrend> trends;

  const ProductivityChart({super.key, required this.trends});

  @override
  Widget build(BuildContext context) {
    if (trends.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(40),
        decoration: BoxDecoration(
          color: AppTheme.whiteColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.darkColor.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Center(
          child: Text(
            'Недостаточно данных для графика',
            style: TextStyle(color: AppTheme.darkColor.withOpacity(0.6)),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      height: 300,
      decoration: BoxDecoration(
        color: AppTheme.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppTheme.darkColor.withOpacity(0.1),
          width: 1,
        ),
      ),
        child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: AppTheme.darkColor.withOpacity(0.1),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: AppTheme.darkColor.withOpacity(0.6),
                    ),
                  );
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 30,
                getTitlesWidget: (value, meta) {
                  final index = value.toInt();
                  if (index >= 0 && index < trends.length) {
                    final period = trends[index].period.split('-');
                    if (period.length == 2) {
                      return Text(
                        period[1],
                        style: TextStyle(
                          fontSize: 10,
                          color: AppTheme.darkColor.withOpacity(0.6),
                        ),
                      );
                    }
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            // Tasks line
            LineChartBarData(
              spots: trends
                  .asMap()
                  .entries
                  .map(
                    (e) => FlSpot(
                      e.key.toDouble(),
                      e.value.tasksCompleted.toDouble(),
                    ),
                  )
                  .toList(),
              isCurved: true,
              color: AppTheme.primaryColor,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: AppTheme.primaryColor.withOpacity(0.2),
              ),
            ),
            // Memories line
            LineChartBarData(
              spots: trends
                  .asMap()
                  .entries
                  .map(
                    (e) => FlSpot(
                      e.key.toDouble(),
                      e.value.memoriesCreated.toDouble(),
                    ),
                  )
                  .toList(),
              isCurved: true,
              color: const Color(0xFF667EEA),
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(
                show: true,
                color: const Color(0xFF667EEA).withOpacity(0.2),
              ),
            ),
          ],
          lineTouchData: LineTouchData(
            touchTooltipData: LineTouchTooltipData(
              tooltipBgColor: AppTheme.whiteColor,
              tooltipBorder: BorderSide(color: AppTheme.darkColor.withOpacity(0.2)),
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  final period = trends[spot.x.toInt()].period;
                  final isTask = spot.barIndex == 0;
                  return LineTooltipItem(
                    '${isTask ? 'Задач' : 'Воспоминаний'}: ${spot.y.toInt()}\n$period',
                    const TextStyle(
                      color: AppTheme.darkColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }
}
