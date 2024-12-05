import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:finals/auth-folder/auth.dart';
import 'package:finals/cart-folder/cart_scaffold.dart';
import 'package:finals/dashboard-folder/dashboard.dart';
import 'package:finals/forget-password-folder/forgot_password_scaffold.dart';
import 'package:finals/inventory-folder/inventory_scaffold.dart';
import 'package:finals/login-folder/login_scaffold.dart';
import 'package:finals/pos-folder/pos_scaffold.dart';
import 'package:finals/settings-folder/settings_scaffold.dart';
import 'package:finals/signup-folder/signup_scaffold.dart';
import 'package:finals/splash-screen-folder/splash_screen_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

void showMessage({required BuildContext context,
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

class FluroRouterSetup {
  static final FluroRouter router = FluroRouter();

  static void setupRoutes() {

    router.define(
      '/ssScaffold',
      handler: Handler(
        handlerFunc: (context, params) =>
            SplashScreenScaffold(), 
      ),
    );

    router.define(
      '/authScaffold',
      handler: Handler(
        handlerFunc: (context, params) =>
            AuthScaffold(), 
      ),
    );

    router.define(
      '/loginScaffold',
      handler: Handler(
        handlerFunc: (context, params) =>
            LoginScaffold(), 
      ),
    );

    router.define(
      '/signUpScaffold',
      handler: Handler(
        handlerFunc: (context, params) =>
            SignupScaffold(), 
      ),
    );

    router.define(
      '/forgotScaffold',
      handler: Handler(
        handlerFunc: (context, params) =>
            ForgotPasswordScaffold(), 
      ),
    );

    router.define(
      '/dashBoardScaffold',
      handler: Handler(
        handlerFunc: (context, params) =>
            DashboardScaffold(), 
      ),
    );

    router.define(
      '/posScaffold',
      handler: Handler(
        handlerFunc: (context, params) => PosScaffold(), 
      ),
    );

    router.define(
      '/settingsScaffold',
      handler: Handler(
        handlerFunc: (context, params) =>
            SettingsScaffold(), 
      ),
    );

    router.define(
      '/invetoryScaffold',
      handler: Handler(
        handlerFunc: (context, params) =>
            InventoryScaffold(), 
      ),
    );
    router.define(
      '/cartScaffold',
      handler: Handler(
        handlerFunc: (context, params) =>
            CartScaffold(), 
      ),
    );
    

  }
}
