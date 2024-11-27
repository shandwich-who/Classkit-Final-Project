import 'package:get/get.dart';

import '../signup-folder/signup_controller.dart';

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

final passTheController = Get.put(SignUpController());

String? validatorConfirmPassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Confirm Password is required';
  } else if (value != passTheController.password) {
    return 'Passwords do not match';
  }
  return null;
}
