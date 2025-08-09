/// Constants used throughout the app.
///
/// These are shared values used across the app that should remain
/// consistent.
class AppConstants {
  /// Maximum alpha value for colors.
  static const int fullAlpha = 255;

  /// Maximum RGB component value (0–255).
  static const int rgbMax = 256;

  /// Shift amount for generating near colors.
  static const double defaultNearColorShift = 0.12;

  /// Factor to darken a color shade.
  /// 
  /// This is the factor used to calculate the new lightness when creating 
  /// a darker shade of a color.
  static const double defaultDarkerShadeFactor = 0.8;

  /// Luminance threshold to decide light/dark text.
  static const double luminanceDarkThreshold = 0.5;

  /// HEX color string length (including alpha).
  static const int hexColorStringLength = 8;

  /// HEX substring start index (skips alpha).
  ///
  /// This is the index of the first character after the alpha channel 
  /// in a HEX color string.
  static const int hexColorSubstringStart = 2;

  /// Character used to pad HEX strings.
  ///
  /// When formatting a color as HEX, this character is used to pad the string
  /// to the expected length.
  static const String hexPadChar = '0';


  /// This is the maximum value for the radix in [int.toRadixString].
  static const int radix = 16;
}
