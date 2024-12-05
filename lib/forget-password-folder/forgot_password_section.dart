import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:finals/text-form-field-validator-folder/validator_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';

class ForgotPasswordSection extends StatefulWidget {
  const ForgotPasswordSection({super.key});

  @override
  State<ForgotPasswordSection> createState() => _ForgotPasswordSectionState();
}

class _ForgotPasswordSectionState extends State<ForgotPasswordSection> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _formKey.currentState?.dispose();
    super.dispose();
  }

  Future<void> _resetUserPassword() async {
    try {
      final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
      if (connectivityResult.contains(ConnectivityResult.none)) {
        if (mounted) {
          showMessage(
            context: context,
            message: "No internet connection. Please check your connection.",
            duration: duration300,
            typeColor: AnimatedSnackBarType.error,
          );
        }
      } else if (connectivityResult.contains(ConnectivityResult.mobile) ||
          connectivityResult.contains(ConnectivityResult.wifi)) {
        if (_formKey.currentState!.validate()) {
          try {
            if (_formKey.currentState!.validate()) {
              await FirebaseAuth.instance
                  .sendPasswordResetEmail(email: _emailController.text.trim());

              // if (mounted) {
              //   showMessage(
              //     context: context,
              //     message: "A password reset link has been sent to your email.",
              //     duration: const Duration(milliseconds: 1500),
              //     typeColor: AnimatedSnackBarType.success,
              //   );
              // }
            } else {}
          } on FirebaseAuthException catch (e) {
            if (mounted) {
              showMessage(
                context: context,
                message: e.code.toString(),
                duration: duration300,
                typeColor: AnimatedSnackBarType.error,
              );
            }
          }
        } else {
          if (mounted) {
            showMessage(
              context: context,
              message:
                  "Kindly resolve the issue to continue creating an account.",
              duration: duration300,
              typeColor: AnimatedSnackBarType.error,
            );
          }
        }
      }
    } on PlatformException catch (e) {
      if (mounted) {
        showMessage(
          context: context,
          message: e.code.toString(),
          duration: duration300,
          typeColor: AnimatedSnackBarType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            FluroRouterSetup.router.navigateTo(
                              context,
                              '/loginScaffold',
                              transition: TransitionType.custom,
                              transitionDuration: Duration(seconds: 1),
                              transitionBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: FadeTransition(
                                    opacity:
                                        ReverseAnimation(secondaryAnimation),
                                    child: child,
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.arrow_back_rounded),
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/recovery.png",
                          height: 200,
                          width: 200,
                        ),
                      ],
                    ),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      keyboardType: TextInputType.emailAddress,
                      validator: validateEmail,
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: "Enter your Email",
                        hintStyle: const TextStyle(color: Colors.grey),
                        labelStyle: const TextStyle(color: Color(0xff1a1a1a)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff1a1a1a), width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xff1a1a1a), width: 1),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton(
                      onPressed: () {
                        _resetUserPassword();
                        if (mounted) {
                          showMessage(
                            context: context,
                            message:
                                "Password reset link has been sent to ${_emailController.text.trim()}.",
                            duration: duration300,
                            typeColor: AnimatedSnackBarType.success,
                          );
                          FluroRouterSetup.router.navigateTo(
                            context,
                            '/loginScaffold',
                            transition: TransitionType.custom,
                            transitionDuration: Duration(seconds: 1),
                            transitionBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: FadeTransition(
                                  opacity: ReverseAnimation(secondaryAnimation),
                                  child: child,
                                ),
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff3e3c6e),
                        foregroundColor: const Color(0xffffffff),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                        elevation: 4,
                      ),
                      child: const Text('Send Link'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
