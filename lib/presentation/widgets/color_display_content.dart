// lib/widgets/color_display_widgets.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_color_generator/core/utils/color_helper.dart';

/// Widget displaying the main "Hello there" text with color information
class ColorDisplayContent extends StatelessWidget {
  /// The background color of the display
  final Color backgroundColor;

  /// Creates a [ColorDisplayContent] with the given background color.
  const ColorDisplayContent({required this.backgroundColor, super.key});

  @override
  Widget build(BuildContext context) {
    final textColor = ColorHelper.readableTextOn(backgroundColor);

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Main greeting text
            Text(
              'Hello there',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: textColor,
                shadows: [
                  Shadow(
                    color: textColor.withValues(alpha: 0.5),
                    offset: const Offset(2, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              semanticsLabel: 'Hello there greeting text',
            ),

            const SizedBox(height: 4),

            // HEX information (tappable to copy)
            _HexColorTile(
              backgroundColor: backgroundColor,
              textColor: textColor,
            ),
          ],
        ),
      ),
    );
  }
}

/// Private widget for HEX color display with copy functionality
class _HexColorTile extends StatelessWidget {
  final Color backgroundColor;
  final Color textColor;

  const _HexColorTile({required this.backgroundColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _copyHexToClipboard(context),
      child: Text(
        ColorHelper.toHex(backgroundColor),
        textAlign: TextAlign.center,
        style: TextStyle(
          color: textColor,
          decoration: TextDecoration.underline,
          fontSize: 16,
        ),
        semanticsLabel: 'Tap to copy HEX color code',
      ),
    );
  }

  /// Copies HEX color to clipboard and shows feedback
  Future<void> _copyHexToClipboard(BuildContext context) async {
    final hexValue = ColorHelper.toHex(backgroundColor);

    await Clipboard.setData(ClipboardData(text: hexValue));

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'HEX copied: $hexValue',
          style: TextStyle(color: textColor),
        ),
        duration: const Duration(seconds: 2),
        backgroundColor: ColorHelper.shiftLightness(backgroundColor),
      ),
    );
  }
}
