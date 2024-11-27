import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';

void showMessage(
    {required BuildContext? context,
    String? message,
    AnimatedSnackBarType? typeColor,
    Duration? duration}) {
  AnimatedSnackBar.material(
    message!,
    type: typeColor!,
    borderRadius: BorderRadius.circular(16),
    animationDuration: duration!,
  ).show(context!);
}
