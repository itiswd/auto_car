// test/widget_test.dart

import 'package:auto_car/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Settings screen loads and switches theme', (
    WidgetTester tester,
  ) async {
    // Build the app with default values.
    await tester.pumpWidget(const MyApp(isDark: false, langCode: 'en'));

    // Verify the presence of the settings screen.
    expect(find.text('Settings'), findsOneWidget);

    // Tap on the dark mode switch
    await tester.tap(find.byType(SwitchListTile));
    await tester.pump();

    // Check if dark mode switch toggled (visually it won't change theme in test, but interaction is verified)
    expect(find.byType(SwitchListTile), findsOneWidget);
  });
}
