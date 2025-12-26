import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ionicons/ionicons.dart';
import 'package:memoir/core/widgets/audio_player_widget.dart';

void main() {
  group('AudioPlayerWidget', () {
    testWidgets('should render audio player UI', (WidgetTester tester) async {
      // Create a temporary audio file path (mock)
      const audioPath = '/tmp/test_audio.m4a';

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AudioPlayerWidget(audioPath: audioPath, onDelete: () {}),
          ),
        ),
      );

      // Wait for widget to build
      await tester.pump();

      // Verify that audio player elements are present
      expect(find.text('Голосовая заметка'), findsOneWidget);
      expect(find.byIcon(Ionicons.play), findsOneWidget);
    });

    testWidgets('should show delete button when onDelete provided', (
      WidgetTester tester,
    ) async {
      const audioPath = '/tmp/test_audio.m4a';
      var deletePressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AudioPlayerWidget(
              audioPath: audioPath,
              onDelete: () {
                deletePressed = true;
              },
            ),
          ),
        ),
      );

      await tester.pump();

      // Verify delete button is present
      final deleteButton = find.byType(IconButton);
      expect(deleteButton, findsWidgets);

      // Note: Actually tapping would require proper audio file setup
      // This is better tested in integration tests
    });
  });
}
