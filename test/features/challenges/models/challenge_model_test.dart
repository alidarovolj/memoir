import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:memoir/features/challenges/data/models/challenge_model.dart';

void main() {
  group('ChallengeModel Tests', () {
    test('should create ChallengeModel from JSON', () {
      final json = {
        'id': '123e4567-e89b-12d3-a456-426614174000',
        'title': 'Test Challenge',
        'description': 'Test Description',
        'emoji': '🎯',
        'start_date': '2025-01-01T00:00:00Z',
        'end_date': '2025-01-31T23:59:59Z',
        'goal': {'type': 'create_memories', 'target': 30},
        'participants_count': 10,
        'is_active': true,
      };

      final challenge = ChallengeModel.fromJson(json);

      expect(challenge.title, 'Test Challenge');
      expect(challenge.emoji, '🎯');
      expect(challenge.participantsCount, 10);
      expect(challenge.isActive, true);
    });

    test('should serialize ChallengeModel to JSON', () {
      final now = DateTime.now();
      final challenge = ChallengeModel(
        id: '123e4567-e89b-12d3-a456-426614174000',
        title: 'Test Challenge',
        description: 'Test Description',
        emoji: '🎯',
        startDate: DateTime.parse('2025-01-01T00:00:00Z'),
        endDate: DateTime.parse('2025-01-31T23:59:59Z'),
        goal: {'type': 'create_memories', 'target': 30},
        participantsCount: 10,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      );

      final json = challenge.toJson();

      expect(json['title'], 'Test Challenge');
      expect(json['emoji'], '🎯');
      expect(json['participants_count'], 10);
    });

    test('should calculate days remaining correctly', () {
      final now = DateTime.now();
      final endDate = now.add(const Duration(days: 5));

      final challenge = ChallengeModel(
        id: '123e4567-e89b-12d3-a456-426614174000',
        title: 'Test',
        description: 'Test',
        emoji: '🎯',
        startDate: now,
        endDate: endDate,
        goal: {},
        participantsCount: 0,
        isActive: true,
        createdAt: now,
        updatedAt: now,
      );

      expect(challenge.daysRemaining, greaterThanOrEqualTo(4));
      expect(challenge.daysRemaining, lessThanOrEqualTo(5));
    });

    test('should indicate if challenge has ended', () {
      final now = DateTime.now();
      final yesterday = now.subtract(const Duration(days: 1));

      final challenge = ChallengeModel(
        id: '123e4567-e89b-12d3-a456-426614174000',
        title: 'Test',
        description: 'Test',
        emoji: '🎯',
        startDate: now.subtract(const Duration(days: 7)),
        endDate: yesterday,
        goal: {},
        participantsCount: 0,
        isActive: true,
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now,
      );

      expect(challenge.hasEnded, true);
    });
  });
}
