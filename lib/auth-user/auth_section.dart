import 'package:finals/dashboard-folder/dashboard_scaffold.dart';
import 'package:finals/login-folder/login_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthSection extends StatelessWidget {
  const AuthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return const DashboardScaffold();
            } else {
              return const LoginScaffold();
            }
          }
          //If the stream is null, return a placeholder widget
          //return const Center(child: CircularProgressIndicator());
        ),
    );
  }
}
