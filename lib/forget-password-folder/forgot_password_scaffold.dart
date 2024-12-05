import 'package:finals/forget-password-folder/forgot_password_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScaffold extends StatelessWidget {
  const ForgotPasswordScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.white,
    //     // statusBarColor: Colors.transparent,
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        // backgroundColor: Color(0xffeaf9e7),
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: ForgotPasswordSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
