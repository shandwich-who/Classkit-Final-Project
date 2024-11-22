import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    Future<void> signUserOut() async {
      FirebaseAuth.instance.signOut();
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: signUserOut, icon: const Icon(Icons.logout)),
          Text("Welcome ${user.email}")

        ],
      ));
  }
}
