import 'package:finals/dashboard-folder/dashboard.dart';
import 'package:finals/login-folder/login_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthScaffold extends StatelessWidget {
  const AuthScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        body: _buildAuthState(),
      ),
    );
  }

  Widget _buildAuthState() {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        Widget targetWidget = snapshot.hasData 
            ? const DashboardScaffold() 
            : const LoginScaffold();    
        return AnimatedSwitcher(
          duration: const Duration(milliseconds: 1000),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: targetWidget,
        );
      },
    );
  }
}
