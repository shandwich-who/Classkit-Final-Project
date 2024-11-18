import 'package:finals/inventory-folder/inventory_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  try {
    runApp(
        // const LoginScaffold()
        // const SplashScreenScaffold()
        // const SignupScaffold()
        // const ForgotPasswordScaffold()
        // const DashboardScaffold()
        const InventoryScaffold());
  } catch (e) {
    Fluttertoast.showToast(
      msg: "This is a toast message.",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }
}
