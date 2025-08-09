import 'package:flutter/material.dart';
import 'package:flutter_color_generator/core/utils/color_helper.dart';

/// Service responsible for generating colors and managing history.
class ColorService {
  /// Maximum number of recent colors stored.
  final int maxHistory;
  final List<Color> _recentColors = [];

  /// Creates a [ColorService] with the given maxHistory.
  ColorService({this.maxHistory = 5});

  /// Generates a completely random color.
  Color generateRandomColor() => ColorHelper.generateRandomColor();

  /// Shifts color lightness for AppBar contrast.
  Color shiftAppBarColor(Color base) => ColorHelper.shiftLightness(base);

  /// Returns an unmodifiable list of recent colors.
  List<Color> getRecentColors() => List.unmodifiable(_recentColors);

  /// Adds a color to recent history (removes duplicates).
  void addToRecent(Color color) {
    _recentColors.removeWhere((c) => c.toARGB32() == color.toARGB32());
    _recentColors.insert(0, color);
    if (_recentColors.length > maxHistory) {
      _recentColors.removeLast();
    }
  }

  /// Clears recent color history.
  void clearHistory() => _recentColors.clear();
}
