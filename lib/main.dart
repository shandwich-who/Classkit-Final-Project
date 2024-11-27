import 'package:finals/firebase_options.dart';
import 'package:finals/login-folder/login_scaffold.dart';
import 'package:finals/signup-folder/signup_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(
        // const AuthScaffold()
        const LoginScaffold()
        // const SplashScreenScaffold()
        // const SignupScaffold()
        // const ForgotPasswordScaffold()
        // const DashboardScaffold()
        // const InventoryScaffold()
        );
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
}
