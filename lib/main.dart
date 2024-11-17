import 'package:finals/forget-password-folder/forgot_password_scaffold.dart';
import 'package:finals/login-folder/login_scaffold.dart';
import 'package:flutter/material.dart';

void main() {
  try {
    runApp(
        const LoginScaffold());
        // const SplashScreenScaffold()
        // const SignupScaffold()
        // const ForgotPasswordScaffold());
  } catch (e) {
    print(e);
  }
}
