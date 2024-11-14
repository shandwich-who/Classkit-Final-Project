import 'package:finals/login-folder/login-section.dart';
import 'package:flutter/material.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        // backgroundColor: Color(0xffeaf9e7),
        backgroundColor: Colors.white,
        body: LoginSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
