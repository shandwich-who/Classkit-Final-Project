import 'package:finals/signup-folder/signup_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SignupScaffold extends StatelessWidget {
  const SignupScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        // statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        resizeToAvoidBottomInset:
          true,
        backgroundColor: Color(0xffFAF9F6),
        body: SignupSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}