import 'package:finals/signup-folder/signup_section.dart';
import 'package:flutter/material.dart';


class SignupScaffold extends StatelessWidget {
  const SignupScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        resizeToAvoidBottomInset:
          true,
        backgroundColor: Colors.white,
        body: SignupSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}