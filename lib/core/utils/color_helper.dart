import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_color_generator/core/constants/app_constants.dart';

/// Utility class for all color-related operations.
class ColorHelper {
  static final Random _random = Random();

  const ColorHelper._();

  /// Generates a random color using a single 24-bit integer for RGB,
  /// combined with a fixed full alpha channel (0xFF).
  ///
  /// This method is **more performant** because it makes **only one call**
  /// to the random number generator and creates the color directly
  /// by bitwise operations.
  ///
  /// It can generate **all 16,777,216** possible RGB colors with full opacity.
  static Color generateRandomColor() => Color(
    AppConstants.fullAlphaHex | _random.nextInt(AppConstants.maxColorValueHex),
  );

  /// Generates a random RGB color by generating each color component
  /// (red, green, blue) separately and then combining them with
  /// full alpha (255).
  ///
  /// This method is **less performant** than [generateRandomColor]
  /// because it calls the random number generator **three times**,
  /// once for each color component.
  ///
  /// It produces the same **16,777,216** possible fully opaque colors.
  static Color generateRandomColorRGB() {
    final r = _random.nextInt(AppConstants.rgbMax);
    final g = _random.nextInt(AppConstants.rgbMax);
    final b = _random.nextInt(AppConstants.rgbMax);

    return Color.fromARGB(AppConstants.fullAlpha, r, g, b);
  }

  /// Returns `true` if [color] is dark.
  static bool isDark(Color color) =>
      color.computeLuminance() < AppConstants.luminanceDarkThreshold;

  /// Returns a readable text color (black or white) for the given [background].
  static Color readableTextOn(Color background) =>
      isDark(background) ? Colors.white : Colors.black;

  /// Formats [color] as HEX (e.g., #RRGGBB).
  static String toHex(Color color) =>
      '''#${color.toARGB32().toRadixString(AppConstants.radix).padLeft(AppConstants.hexColorStringLength, AppConstants.hexPadChar).substring(AppConstants.hexColorSubstringStart).toUpperCase()}''';

  /// Returns a color with shifted lightness from [base].
  /// Increases or decreases the lightness by [shift].
  static Color shiftLightness(
    Color base, {
    double shift = AppConstants.defaultNearColorShift,
  }) {
    final hsl = HSLColor.fromColor(base);
    final bool lighter = _random.nextBool();
    final double newLightness = (hsl.lightness + (lighter ? shift : -shift))
        .clamp(0.0, 1.0);

    return hsl.withLightness(newLightness).toColor();
  }
}
