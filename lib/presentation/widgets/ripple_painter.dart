import 'package:flutter/material.dart';
import 'package:flutter_color_generator/core/models/ripple_data.dart';

/// Custom painter for ripple effect
class RipplePainter extends CustomPainter {
  /// The center point of the ripple.
  final Offset origin;

  /// The radius of the ripple.
  final double radius;

  /// The color of the ripple.
  final Color color;

  /// Creates a [RipplePainter] with the given origin, radius, and color.
  const RipplePainter({
    required this.origin,
    required this.radius,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    canvas.drawCircle(origin, radius, paint);
  }

  @override
  bool shouldRepaint(covariant RipplePainter oldDelegate) {
    return oldDelegate.radius != radius ||
        oldDelegate.color != color ||
        oldDelegate.origin != origin;
  }
}

/// Widget that manages ripple animation
class RippleAnimationOverlay extends StatelessWidget {
  /// The data for the ripple animation.
  final RippleData rippleData;

  /// Controls the radius of the ripple during the animation.
  final Animation<double> radiusAnimation;

  /// Creates a [RippleAnimationOverlay]
  /// With the given ripple data and radius animation.
  const RippleAnimationOverlay({
    required this.rippleData,
    required this.radiusAnimation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: radiusAnimation,
      builder: (_, __) {
        return CustomPaint(
          painter: RipplePainter(
            origin: rippleData.origin,
            radius: radiusAnimation.value,
            color: rippleData.color,
          ),
        );
      },
    );
  }
}
