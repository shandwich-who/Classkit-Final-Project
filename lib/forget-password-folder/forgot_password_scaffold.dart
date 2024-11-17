import 'package:finals/forget-password-folder/forgot_password_section.dart';
import 'package:flutter/material.dart';

class ForgotPasswordScaffold extends StatelessWidget {
  const ForgotPasswordScaffold({super.key});

  @override
  Widget build(BuildContext context) {
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
