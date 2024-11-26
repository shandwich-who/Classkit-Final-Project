import 'package:finals/firebase_options.dart';
import 'package:finals/inventory-folder/inventory_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      // const AuthScaffold()
      //const LoginScaffold()
      // const SplashScreenScaffold()
      // const SignupScaffold()
      // const ForgotPasswordScaffold()
      // const DashboardScaffold()
      const InventoryScaffold()
      );
}

