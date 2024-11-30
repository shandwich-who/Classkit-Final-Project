import 'package:finals/dashboard-folder/dashboard.dart';
import 'package:finals/login-folder/login_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthSection extends StatelessWidget {
  const AuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const DashboardScaffold();
        } else {
          return const LoginScaffold();
        }
      },
    );
  }
}
