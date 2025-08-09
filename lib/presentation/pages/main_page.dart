import 'package:flutter/material.dart';
import 'package:flutter_color_generator/core/models/ripple_data.dart';
import 'package:flutter_color_generator/core/services/color_service.dart';
import 'package:flutter_color_generator/presentation/widgets/color_display_content.dart';
import 'package:flutter_color_generator/presentation/widgets/main_app_bar.dart';
import 'package:flutter_color_generator/presentation/widgets/recent_colors_strip.dart';
import 'package:flutter_color_generator/presentation/widgets/ripple_painter.dart';

///
class MainPage extends StatefulWidget {
  /// The main screen of the app
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  final _colorService = ColorService();
  Color _backgroundColor = Colors.white;
  Color _appBarColor = Colors.blue;
  RippleData? _currentRipple;

  late AnimationController _rippleController;
  Animation<double> _radiusAnimation = const AlwaysStoppedAnimation(0.0);

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..addStatusListener(_handleAnimationStatus);
  }

  void _handleTap(Offset position, Size screenSize) {
    if (_rippleController.isAnimating) return;
    final newColor = _colorService.generateRandomColor();
    final rippleData = RippleData.origin(position, screenSize, newColor);

    setState(() => _currentRipple = rippleData);

    _radiusAnimation = Tween<double>(begin: 0.0, end: rippleData.maxRadius)
        .animate(
          CurvedAnimation(
            parent: _rippleController,
            curve: Curves.easeOutCubic,
          ),
        );

    _rippleController.forward();
  }

  void _handleAnimationStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    final ripple = _currentRipple;
    if (ripple == null) return;

    setState(() {
      _backgroundColor = ripple.color;
      _appBarColor = _colorService.shiftAppBarColor(ripple.color);
      _colorService.addToRecent(ripple.color);
      _currentRipple = null;
    });

    _rippleController.reset();
  }

  void _selectRecentColor(Color color) {
    setState(() {
      _backgroundColor = color;
      _appBarColor = _colorService.shiftAppBarColor(color);
    });
  }

  void _resetApp() {
    _rippleController.stop();
    _rippleController.reset();
    _colorService.clearHistory();
    setState(() {
      _backgroundColor = Colors.white;
      _appBarColor = Colors.blue;
      _currentRipple = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        final screenSize = Size(constraints.maxWidth, constraints.maxHeight);
        final ripple = _currentRipple;

        return Scaffold(
          appBar: MainAppBar(
            backgroundColor: _appBarColor,
            title: 'Color Tap Generator',
            onReset: _resetApp,
          ),
          body: GestureDetector(
            key: const Key('color_tap_area'),
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) =>
                _handleTap(details.globalPosition, screenSize),
            child: Stack(
              children: [
                Container(
                  key: const Key('color_display_container'),
                  color: _backgroundColor,
                ),
                if (ripple != null)
                  RippleAnimationOverlay(
                    rippleData: ripple,
                    radiusAnimation: _radiusAnimation,
                  ),
                ColorDisplayContent(backgroundColor: _backgroundColor),
                RecentColorsStrip(
                  key: const Key('recent_colors_strip'),
                  recentColors: _colorService.getRecentColors(),
                  currentColor: _backgroundColor,
                  onColorSelected: _selectRecentColor,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    super.dispose();
  }
}
