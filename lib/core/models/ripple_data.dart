import 'dart:math';
import 'dart:ui';

/// Model class to hold ripple animation data
class RippleData {
  /// The center point of the ripple.
  final Offset origin;

  /// The color of the ripple.
  final Color color;

  /// The maximum radius of the ripple.
  final double maxRadius;

  /// Creates a [RippleData] with the given origin, color, and max radius.
  const RippleData({
    required this.origin,
    required this.color,
    required this.maxRadius,
  });

  /// Factory constructor to create ripple data with random origin
  factory RippleData.random(Size screenSize, Color targetColor) {
    final random = Random();
    final origin = Offset(
      random.nextDouble() * screenSize.width,
      random.nextDouble() * screenSize.height,
    );

    final maxRadius = _calculateMaxRadius(origin, screenSize);

    return RippleData(origin: origin, color: targetColor, maxRadius: maxRadius);
  }

  /// Factory constructor to create ripple data with given origin
  factory RippleData.origin(Offset origin, Size screenSize, Color targetColor) {
    final maxRadius = _calculateMaxRadius(origin, screenSize);

    return RippleData(origin: origin, color: targetColor, maxRadius: maxRadius);
  }

  /// Calculates the maximum radius needed to cover entire screen
  static double _calculateMaxRadius(Offset origin, Size screenSize) {
    final corners = [
      Offset.zero,
      Offset(screenSize.width, 0),
      Offset(0, screenSize.height),
      Offset(screenSize.width, screenSize.height),
    ];

    return corners.map((corner) => (origin - corner).distance).reduce(max);
  }
}
