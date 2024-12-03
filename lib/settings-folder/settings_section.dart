import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({super.key});

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  final _user = FirebaseAuth.instance.currentUser!;
  bool _isLoading = false;

  Future<void> _signUserOut() async {
    setState(() {
      _isLoading = true;
    });

    try {
      if (_user.providerData
          .any((provider) => provider.providerId == 'google.com')) {
        await GoogleSignIn().signOut();
      }
      await FirebaseAuth.instance.signOut();

      if (mounted) {
        showMessage(
          context: context,
          message: "Signed out successfully",
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
    } on PlatformException catch (e) {
      if (mounted) {
        showMessage(
          context: context,
          message: "Error signing out: ${e.code.toString()}",
          duration: const Duration(milliseconds: 1500),
          typeColor: AnimatedSnackBarType.error,
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 275,
        height: 375,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 4,
              blurRadius: 12,
              offset: const Offset(-6, -6),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 6,
              blurRadius: 14,
              offset: const Offset(6, 6),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Email: ${_user.email}",
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800]),
              ),
              SizedBox(
                height: 30,
              ),
              _isLoading
                  ? CircularProgressIndicator()
                  : PrettyWaveButton(
                      onPressed: () {
                        Future.delayed(Duration(milliseconds: 300), () {
                          _signUserOut();
                        });
                      },
                      curve: Curves.fastEaseInToSlowEaseOut,
                      child: Text(
                        "S i g n  O u t",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
