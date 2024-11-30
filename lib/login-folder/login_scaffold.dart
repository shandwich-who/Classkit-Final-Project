import 'package:finals/login-folder/login_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({super.key});

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
        // backgroundColor: Color(0xffeaf9e7),
        backgroundColor: Color(0xffFAF9F6),
        resizeToAvoidBottomInset:
          true,
        body: LoginSection(),
      ),
      theme: ThemeData(useMaterial3: false),
      // onGenerateRoute: FluroRouterSetup.router.generator,

    );
  }
}
