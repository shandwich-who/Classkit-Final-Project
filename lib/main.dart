import 'package:flutter/material.dart';

import 'dashboard-folder/dashboard_scaffold.dart';

void main() {
  try {
    runApp(
        // const LoginScaffold()
        // const SplashScreenScaffold()
        // const SignupScaffold()
        // const ForgotPasswordScaffold()
        const DashboardScaffold()
        // const InventoryScaffold());
        );
  } catch (e) {
    Dialog(
      child: Text(e.toString()),
    );
  }
}
