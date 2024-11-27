import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../show-message-folder/show_message.dart';

class SearchSection extends StatefulWidget {
  const SearchSection({super.key});

  @override
  State<SearchSection> createState() => _SearchSectionState();
}

class _SearchSectionState extends State<SearchSection> {
  final _user = FirebaseAuth.instance.currentUser!;

  Future<void> _signUserOut() async {
    try {
      await FirebaseAuth.instance.signOut();

      if (mounted) {
        showMessage(
          context: context,
          message: "Successfully Login",
          duration: const Duration(milliseconds: 1500),
          typeColor: AnimatedSnackBarType.success,
        );
      }
    } on FirebaseAuthException catch (e) {
      String message = e.code.toString();
      if (mounted) {
        showMessage(
          context: context,
          message: message,
          duration: const Duration(milliseconds: 1500),
          typeColor: AnimatedSnackBarType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              _signUserOut;
            },
            icon: const Icon(Icons.logout)),
        Text("Welcome ${_user.email}")
      ],
    ));
  }
}
