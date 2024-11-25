import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:finals/inventory-folder/inventory_scaffold.dart';
import 'package:finals/pos-folder/pos_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../search-folder/search_scaffold.dart';

class BnbController extends GetxController {
  RxInt index = 0.obs;
  var pages = [
    const PosScaffold(),
    const SearchScaffold(),
    const InventoryScaffold()
  ];
}

BnbController controlNavBar = Get.put(BnbController());

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Email cannot be empty';
  }
  value = value.trim();
  if (value.length > 254) {
    return 'Email is too long (maximum 254 characters)';
  }
  final RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  if (!emailRegExp.hasMatch(value)) {
    return 'Please enter a valid email address (e.g., example@domain.com)';
  }
  if (value.contains(' ')) {
    return 'Email cannot contain spaces';
  }
  if (value.contains('..') || value.contains('@@')) {
    return 'Email cannot contain consecutive special characters';
  }
  if (value.startsWith(RegExp(r'[^a-zA-Z0-9]'))) {
    return 'Email cannot start with a special character';
  }
  if (!value.contains('.') || value.split('.').last.isEmpty) {
    return 'Email domain must include a dot (e.g., .com, .org)';
  }
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Password cannot be empty';
  }
  if (value.length < 8) {
    return 'Password must be at least 8 characters long';
  }
  final RegExp upperCaseRegExp = RegExp(r'(?=.*[A-Z])');
  final RegExp lowerCaseRegExp = RegExp(r'(?=.*[a-z])');
  final RegExp digitRegExp = RegExp(r'(?=.*\d)');
  final RegExp specialCharRegExp = RegExp(r'(?=.*[@#$%^&+=])');
  if (!upperCaseRegExp.hasMatch(value)) {
    return 'Password must contain at least one uppercase letter';
  }
  if (!lowerCaseRegExp.hasMatch(value)) {
    return 'Password must contain at least one lowercase letter';
  }
  if (!digitRegExp.hasMatch(value)) {
    return 'Password must contain at least one number';
  }
  if (!specialCharRegExp.hasMatch(value)) {
    return 'Password must contain at least one special character (e.g., @, #, \$, %, etc.)';
  }
  return null;
}

void showErrorMessage(
    {required BuildContext context,
    String? message,
    AnimatedSnackBarType? typecolor,
    Duration? duration}) {
  AnimatedSnackBar.material(
    message!,
    type: typecolor!,
    borderRadius: BorderRadius.circular(16),
    animationDuration: Durations.short4,
  ).show(context);
}

Future<void> signUserIn({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    switch (e.code) {
      default:
        errorMessage = e.code.toString();
        
    }
    AnimatedSnackBar.rectangle(
            "Oops! Something went wrong",
            animationCurve: Curves.bounceInOut,
            errorMessage,
            type: AnimatedSnackBarType.error,
            animationDuration: Durations.short4,
            brightness: Brightness.dark)
        .show(context);
  }
}

Future<void> signUserUp({
  required String email,
  required String password,
  required String confirmPassword,
  required BuildContext context,
}) async {
  try {
    if (password == confirmPassword) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } else {
      AnimatedSnackBar.rectangle(
        "Oops! Something went wrong",
        "Oops! Your passwords don't match. Please try again.",
        type: AnimatedSnackBarType.error,
        brightness: Brightness.dark,
      ).show(
        context,
      );
      return;
    }
    // AnimatedSnackBar.rectangle(
    //   'Success',
    //   'You successfully created an account',
    //   type: AnimatedSnackBarType.success,
    //   brightness: Brightness.light,
    // ).show(
    //   // ignore: use_build_context_synchronously
    //   context,
    // );
    // Navigator.push(
    //   // ignore: use_build_context_synchronously
    //   context,
    //   MaterialPageRoute(builder: (context) => const AuthSection()),
    // );
  } on FirebaseAuthException catch (e) {
    String errorMessage;
    switch (e.code) {
      default:
        errorMessage = e.code.toString();
    }

    AnimatedSnackBar.rectangle(
      "Oops! Something went wrong",
      errorMessage,
      type: AnimatedSnackBarType.error,
      brightness: Brightness.dark,
      // ignore: use_build_context_synchronously
    ).show(context);
  }
}

Future<void> signUserOut({required BuildContext context}) async {
  try {
    await FirebaseAuth.instance.signOut();
  } on FirebaseAuthException catch (e) {
    String message = e.code.toString();
    AnimatedSnackBar.rectangle(
      "Oops! Something went wrong",
      message,
      type: AnimatedSnackBarType.error,
      brightness: Brightness.dark,
      // ignore: use_build_context_synchronously
    ).show(context);
  }
}

// await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

Future resetUserPassword({
  required String email,
  required BuildContext context,
}) async {
  try {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  } on FirebaseAuthException catch (e) {
    AnimatedSnackBar.rectangle(
      "Oops! Something went wrong",
      e.code.toString(),
      type: AnimatedSnackBarType.error,
      brightness: Brightness.dark,
      // ignore: use_build_context_synchronously
    ).show(context);
  }
}
