import 'package:flutter/material.dart';
import 'package:flutter_color_generator/core/utils/color_helper.dart';

/// A custom [AppBar] widget for the main screen.
class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The background color of the app bar.
  final Color backgroundColor;

  /// The title text displayed in the app bar.
  final String title;

  /// Callback triggered when the reset button is pressed.
  final VoidCallback onReset;

  /// Creates a [MainAppBar] with the given background color, title,
  /// and reset callback.
  const MainAppBar({
    required this.backgroundColor,
    required this.title,
    required this.onReset,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      title: Text(
        title,
        style: TextStyle(color: ColorHelper.readableTextOn(backgroundColor)),
      ),
      actions: [
        IconButton(
          key: const Key('reset_button'),
          onPressed: onReset,
          icon: Icon(
            Icons.refresh,
            color: ColorHelper.readableTextOn(backgroundColor),
          ),
          tooltip: 'Reset colors',
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
