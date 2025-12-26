import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pet Service Tests', () {
    test('XP calculation for level up', () {
      // Level 1 → 2: 100 XP
      expect(calculateXPForLevel(1), 100);

      // Level 5 → 6: 500 XP
      expect(calculateXPForLevel(5), 500);

      // Level 10 → 11: 1000 XP
      expect(calculateXPForLevel(10), 1000);
    });

    test('Evolution stage calculation', () {
      expect(getEvolutionStage(0, 5), 0); // Egg (0-4)
      expect(getEvolutionStage(5, 10), 1); // Baby (5-14)
      expect(getEvolutionStage(15, 25), 2); // Adult (15-29)
      expect(getEvolutionStage(30, 50), 3); // Legend (30+)
    });

    test('Happiness decay calculation', () {
      final lastFed = DateTime.now().subtract(const Duration(days: 2));
      final happiness = calculateHappiness(lastFed, 100);

      // After 2 days, happiness should decrease
      expect(happiness, lessThan(100));
      expect(happiness, greaterThanOrEqualTo(0));
    });
  });
}

// Helper functions (these would normally be in the service)
int calculateXPForLevel(int level) {
  return level * 100;
}

int getEvolutionStage(int level, int maxLevel) {
  if (level < 5) return 0;
  if (level < 15) return 1;
  if (level < 30) return 2;
  return 3;
}

int calculateHappiness(DateTime lastFed, int currentHappiness) {
  final hoursSinceLastFed = DateTime.now().difference(lastFed).inHours;
  final decay = (hoursSinceLastFed / 24 * 10).round(); // 10 points per day
  return (currentHappiness - decay).clamp(0, 100);
}
