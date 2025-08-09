import 'package:flutter/material.dart';
import 'package:flutter_color_generator/presentation/pages/main_page.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MainPage Widget Tests', () {
    Future<void> buildMainPage(WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: MainPage()));
      await tester.pumpAndSettle();
    }

    testWidgets('changes background color on tap', (tester) async {
      await buildMainPage(tester);

      // Get initial background color
      final initialContainer = tester.widget<Container>(
        find.byKey(const Key('color_display_container')),
      );
      final initialColor = initialContainer.color;

      // Tap anywhere to change color
      await tester.tap(find.byKey(const Key('color_tap_area')));
      await tester.pumpAndSettle();

      // Get new background color
      final newContainer = tester.widget<Container>(
        find.byKey(const Key('color_display_container')),
      );
      final newColor = newContainer.color;

      // Assert they are different
      expect(newColor, isNot(equals(initialColor)));
    });

    testWidgets('adds tapped color to recent colors strip', (tester) async {
      await buildMainPage(tester);

      // Tap to generate a color
      await tester.tap(find.byKey(const Key('color_tap_area')));
      await tester.pumpAndSettle();

      // Expect the recent colors strip to be present
      final recentStripFinder = find.byKey(const Key('recent_colors_strip'));
      expect(recentStripFinder, findsOneWidget);

      // Ensure at least one recent color is displayed
      final recentColors = find.descendant(
        of: recentStripFinder,
        matching: find.byType(GestureDetector),
      );
      expect(recentColors, findsWidgets);
    });

    testWidgets('resets app state when reset button is tapped', (tester) async {
      await buildMainPage(tester);

      // Change color first
      await tester.tap(find.byKey(const Key('color_tap_area')));
      await tester.pumpAndSettle();

      // Tap reset button
      await tester.tap(find.byKey(const Key('reset_button')));
      await tester.pumpAndSettle();

      // Check if background color is reset to white
      final container = tester.widget<Container>(
        find.byKey(const Key('color_display_container')),
      );
      expect(container.color, equals(Colors.white));

      // Optionally check if recent colors strip is cleared
      final recentStripFinder = find.byKey(const Key('recent_colors_strip'));
      final recentColors = find.descendant(
        of: recentStripFinder,
        matching: find.byType(GestureDetector),
      );
      expect(recentColors, findsNothing);
    });
  });
}
