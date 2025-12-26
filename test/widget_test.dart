import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Basic app structure test', (WidgetTester tester) async {
    // Simple test to verify Flutter test environment works
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text('Test'))),
      ),
    );

    expect(find.text('Test'), findsOneWidget);
  });
}
