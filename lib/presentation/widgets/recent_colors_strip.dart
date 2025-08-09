import 'package:flutter/material.dart';
import 'package:flutter_color_generator/core/utils/color_helper.dart';

/// Widget for displaying recent colors history
class RecentColorsStrip extends StatelessWidget {
  /// The list of recent colors to display.
  final List<Color> recentColors;

  /// The currently selected color.
  final Color currentColor;

  /// Callback triggered when a recent color is selected.
  final ValueChanged<Color> onColorSelected;

  /// Creates a [RecentColorsStrip] with the given recent colors, current color,
  /// and onColorSelected callback.
  const RecentColorsStrip({
    required this.recentColors,
    required this.currentColor,
    required this.onColorSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (recentColors.isEmpty) {
      return const SizedBox.shrink();
    }

    return Positioned(
      bottom: 20,
      left: 16,
      right: 16,
      child: SizedBox(
        height: 56,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: recentColors.length,
          separatorBuilder: (_, __) => const SizedBox(width: 8),
          itemBuilder: (_, index) {
            final color = recentColors[index];
            final isSelected = color.toARGB32() == currentColor.toARGB32();

            return _ColorHistoryTile(
              color: color,
              isSelected: isSelected,
              onTap: () => onColorSelected(color),
            );
          },
        ),
      ),
    );
  }
}

/// Private widget for individual color history tile
class _ColorHistoryTile extends StatelessWidget {
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ColorHistoryTile({
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: isSelected
              ? Border.all(color: ColorHelper.readableTextOn(color), width: 2)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
  }
}
