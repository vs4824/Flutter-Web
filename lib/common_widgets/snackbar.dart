import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar({
  required BuildContext context,
  required String title,
  Duration duration = const Duration(milliseconds: 2000),
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context).clearSnackBars();
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      duration: duration,
      behavior: SnackBarBehavior.floating,
      action: action,
    ),
  );
}