import 'package:flutter/material.dart';
import 'package:flutter_color_generator/main.dart' as app;
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('User can generate colors and see them in recent list', (
    tester,
  ) async {
    app.main();
    await tester.pumpAndSettle();

    // Wait until splash screen finishes and main page appears
    await tester.pump(
      const Duration(seconds: 3),
    ); // splash animation duration + buffer
    await tester.pumpAndSettle();

    // Verify we are on the main page
    expect(find.text('Color Tap Generator'), findsOneWidget);

    // Tap to generate a few colors
    final tapArea = find.byKey(const Key('color_tap_area'));
    await tester.tap(tapArea);
    await tester.pumpAndSettle();

    await tester.tap(tapArea);
    await tester.pumpAndSettle();

    // Verify recent colors strip has items
    final recentColorsList = find.byKey(const Key('recent_colors_strip'));
    expect(recentColorsList, findsOneWidget);
  });
}
