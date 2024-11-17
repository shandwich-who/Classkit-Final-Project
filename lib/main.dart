import 'package:finals/forget-password-folder/forgot_password_scaffold.dart';
import 'package:finals/login-folder/login_scaffold.dart';
import 'package:finals/splash-screen-folder/splash_screen_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  try {
    runApp(
        const LoginScaffold()
        // const SplashScreenScaffold()
        // const SignupScaffold()
        // const ForgotPasswordScaffold()
       
    );
  } catch (e) {
    Fluttertoast.showToast(
  msg: "This is a toast message.",
  toastLength: Toast.LENGTH_SHORT,
  gravity: ToastGravity.BOTTOM,);
  }
}
