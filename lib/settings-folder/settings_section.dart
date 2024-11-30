
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Import this for Google sign-out

import '../show-message-folder/show_message.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({super.key});

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  final _user = FirebaseAuth.instance.currentUser!;

  Future<void> _signUserOut() async {
    try {
      if (_user.providerData
          .any((provider) => provider.providerId == 'google.com')) {
        await GoogleSignIn().signOut();
      }
      await FirebaseAuth.instance.signOut();

      // if (mounted) {
      //   FluroRouterSetup.router.navigateTo(
      //     context,
      //     '/authScaffold',
      //     replace: true,
      //     clearStack: true,
      //     transition: TransitionType.cupertino,
      //   );
      // }
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
    } on PlatformException catch (e) {
      if (mounted) {
        showMessage(
          context: context,
          message: "Error signing out: ${e.code.toString()}",
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
            onPressed: _signUserOut, // Call the function properly
            icon: const Icon(Icons.logout),
          ),
          Text("Welcome ${_user.email}")
        ],
      ),
    );
  }
}
