import 'package:flutter/material.dart';

class ShowSnackBar {
  static void showSnackbar({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    Duration duration = const Duration(seconds: 3),
  }) {
    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor:
          backgroundColor ?? Theme.of(context).colorScheme.secondary,
      duration: duration,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
