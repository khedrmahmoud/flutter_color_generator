import 'package:flutter/material.dart';
import 'package:flutter_color_generator/core/utils/color_helper.dart';
import 'package:flutter_color_generator/presentation/pages/main_page.dart';

/// Simple animated splash screen
class SplashScreen extends StatefulWidget {
  /// Simple animated splash screen
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Animation<double> _fadeAnimation = const AlwaysStoppedAnimation(0.0);
  Color _backgroundColor = Colors.white;

  @override
  void initState() {
    super.initState();
    _backgroundColor = ColorHelper.generateRandomColor();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _controller.forward().then((_) => _navigateToMain());
  }

  void _navigateToMain() {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => const MainPage(),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textColor = ColorHelper.readableTextOn(_backgroundColor);

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Color Tap Generator',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
              const SizedBox(height: 20),
              CircularProgressIndicator(color: textColor),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
