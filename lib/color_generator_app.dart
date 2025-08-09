import 'package:flutter/material.dart';
import 'package:flutter_color_generator/presentation/pages/splash_screen.dart';

///
class ColorGeneratorApp extends StatelessWidget {
  /// The main application widget.
  const ColorGeneratorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color Tap Generator',
      theme: ThemeData(
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
