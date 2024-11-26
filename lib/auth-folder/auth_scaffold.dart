import 'package:flutter/material.dart';

import 'auth_section.dart';

class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: AuthSection(),
      ),
    );
  }
}
