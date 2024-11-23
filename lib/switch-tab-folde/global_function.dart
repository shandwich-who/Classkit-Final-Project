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

  final RegExp emailRegExp =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
  if (!emailRegExp.hasMatch(value)) {
    return 'Please enter a valid email address (e.g., example@domain.com)';
  }

  if (value.contains(' ')) {
    return 'Email cannot contain spaces';
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


