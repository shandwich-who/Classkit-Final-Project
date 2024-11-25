import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:finals/inventory-folder/inventory_scaffold.dart';
import 'package:finals/pos-folder/pos_scaffold.dart';
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

void showMessage(
    {required BuildContext context,
    String? message,
    AnimatedSnackBarType? typeColor,
    Duration? duration}) {
  AnimatedSnackBar.material(
    message!,
    type: typeColor!,
    borderRadius: BorderRadius.circular(16),
    animationDuration: duration!,
  ).show(context);
}

// class UserController {
//   static Future<User?> loginWithGoogle() async {
//     final googleAccount = await GoogleSignIn().signIn();
//
//     final googleAuth = await googleAccount?.authentication;
//
//     final credential = GoogleAuthProvider.credential(
//         accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
//
//     final userCredential = await FirebaseAuth.instance.signInWithCredential(
//       credential,
//     );
//
//     return userCredential.user;
//   }
// }
