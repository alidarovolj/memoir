import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:memoir/core/widgets/custom_header.dart';

void main() {
  group('CustomHeader Widget Tests', () {
    testWidgets('should display title correctly', (WidgetTester tester) async {
      const testTitle = 'Test Title';

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomHeader(title: testTitle, type: HeaderType.none),
          ),
        ),
      );

      expect(find.text(testTitle), findsOneWidget);
    });

    testWidgets('should show back button with HeaderType.pop', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Navigator(
              onGenerateRoute: (settings) {
                return MaterialPageRoute(
                  builder: (context) => const Scaffold(
                    body: CustomHeader(title: 'Test', type: HeaderType.pop),
                  ),
                );
              },
            ),
          ),
        ),
      );

      // Should find back button icon
      expect(find.byType(IconButton), findsWidgets);
    });

    testWidgets('should not show back button with HeaderType.none', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: CustomHeader(title: 'Test', type: HeaderType.none),
          ),
        ),
      );

      // Should not find back button
      expect(find.byType(IconButton), findsNothing);
    });
  });
}
