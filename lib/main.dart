import 'package:finals/splash-screen-folder/splash_screen_scaffold.dart';
import 'package:flutter/material.dart';

void main() {
  try {
    runApp(
        // const LoginScaffold()
        const SplashScreenScaffold()
        // const SignupScaffold()
        // const ForgotPasswordScaffold()
        // const DashboardScaffold()
        // const InventoryScaffold());
        );
  } catch (e) {
    Dialog(
      child: Text(e.toString()),
    );
  }
}
