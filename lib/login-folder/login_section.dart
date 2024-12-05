import 'dart:async';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:finals/text-form-field-validator-folder/validator_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pretty_animated_buttons/configs/pkg_sizes.dart';

class LoginSection extends StatefulWidget {
  const LoginSection({super.key});

  @override
  State<LoginSection> createState() => _LoginSectionState();
}

class _LoginSectionState extends State<LoginSection> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _signUserIn() async {
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
            await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim(),
            ); 
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
              message: "Kindly resolve the issue to continue logging in.",
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

Future<User?> _googleSignIn() async {
  try {
    final googleAccount = await GoogleSignIn().signIn();
    if (googleAccount == null) return null;

    final googleAuth = await googleAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    return userCredential.user;
  } catch (e) {
    showMessage(
        context: mounted ? context : context,
        message: "Google Sign In Error: $e",
        duration: duration300,
        typeColor: AnimatedSnackBarType.error,
      );
    return null;
  }
}

Future<void> _handleGoogleSignIn(BuildContext context) async {
  try {
    final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.none)) {
      showMessage(
        context: mounted ? context : context,
        message: "No internet connection. Please check your connection.",
        duration: duration300,
        typeColor: AnimatedSnackBarType.error,
      );
      return;
    }

    final User? user = await _googleSignIn();
    if (user != null) {
      
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email ?? '',
        'createdAt': FieldValue.serverTimestamp(),

      }, SetOptions(merge: true));

      // showMessage(
      //   context: mounted ? context : context,
      //   message: "Sucessfully save in firestore",
      //   duration: Duration(milliseconds: 1500),
      //   typeColor: AnimatedSnackBarType.success,
      // );

    } else {
      showMessage(
        context: mounted ? context : context,
        message: "Google Sign-In Aborted",
        duration: duration300,
        typeColor: AnimatedSnackBarType.error,
      );
    }
  } on FirebaseAuthException catch (e) {
    showMessage(
      context: mounted ? context : context,
      message: "Authentication Error: ${e.code}",
     duration: duration300,
      typeColor: AnimatedSnackBarType.error,
    );
  } on PlatformException catch (e) {
    showMessage(
      context: mounted ? context : context,
      message: "Error: ${e.code}",
     duration: duration300,
      typeColor: AnimatedSnackBarType.error,
    );
  } catch (e) {
    showMessage(
      context: mounted ? context : context,
      message: "Unexpected Error: $e",
     duration: duration300,
      typeColor: AnimatedSnackBarType.error,
    );
  }
}

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _formKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/signin.png",
                        height: 200,
                        width: 200,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: validateEmail,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          keyboardType: TextInputType.emailAddress,
                          controller: _emailController,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle:
                                const TextStyle(color: Color(0xff1a1a1a)),
                            hintText: "example@domain.com",
                            hintStyle: const TextStyle(color: Colors.grey),
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
                        const SizedBox(height: 25),
                        TextFormField(
                          // keyboardType: TextInputType.visiblePassword,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: validatePassword,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            hintText: "Enter your Password",
                            hintStyle: const TextStyle(color: Colors.grey),
                            labelStyle:
                                const TextStyle(color: Color(0xff1a1a1a)),
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
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                FluroRouterSetup.router.navigateTo(
                                  context,
                                  '/forgotScaffold',
                                  transition: TransitionType.custom,
                                  transitionDuration:
                                      Duration(milliseconds: 800),
                                  transitionBuilder: (context, animation,
                                      secondaryAnimation, child) {
                                    return AnimatedBuilder(
                                      animation: animation,
                                      builder: (context, child) {
                                        final opacity = Curves.easeIn
                                            .transform(animation.value);
                                        final scale = Curves.easeInOut
                                            .transform(animation.value);
                                        return Opacity(
                                          opacity: opacity,
                                          child: Transform.scale(
                                            scale: scale,
                                            child: child,
                                          ),
                                        );
                                      },
                                      child: child,
                                    );
                                  },
                                );
                              },
                              child: const Text(
                                "Forgot Password ?",
                                style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Poppins"),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            _signUserIn();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff4da674),
                            foregroundColor: const Color(0xff1a1a1a),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(double.infinity, 50),
                            elevation: 4,
                          ),
                          child: const Text('LOGIN'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text("Or sign in with"),
                      ),
                      Expanded(
                        child: Divider(
                          color: Colors.black,
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      _handleGoogleSignIn(context);
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: const Color(0xff1a1a1a),
                      backgroundColor: const Color(0xffffffff),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 4,
                      shadowColor: const Color(0xff1a1a1a),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'images/google.png',
                          height: 24,
                          width: 24,
                        ),
                        const SizedBox(width: 60),
                        const Text('Sign in with Google'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Don't have an account yet?",
                        style: TextStyle(
                          color: Color(0xff1a1a1a),
                          fontFamily: "Poppins",
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          FluroRouterSetup.router.navigateTo(
                            context,
                            '/signUpScaffold',
                            transition: TransitionType.custom,
                            transitionDuration: Duration(milliseconds: 800),
                            transitionBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return AnimatedBuilder(
                                animation: animation,
                                builder: (context, child) {
                                  final opacity =
                                      Curves.easeIn.transform(animation.value);
                                  final scale = Curves.easeInOut
                                      .transform(animation.value);
                                  return Opacity(
                                    opacity: opacity,
                                    child: Transform.scale(
                                      scale: scale,
                                      child: child,
                                    ),
                                  );
                                },
                                child: child,
                              );
                            },
                          );
                        },
                        child: const Text(
                          "Sign up here!",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 12.5,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
