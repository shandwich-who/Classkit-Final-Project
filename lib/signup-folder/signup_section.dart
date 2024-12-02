import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:finals/text-form-field-validator-folder/validator_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class SignupSection extends StatefulWidget {
  const SignupSection({super.key});

  @override
  State<SignupSection> createState() => _SignupSectionState();
}

class _SignupSectionState extends State<SignupSection> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();


  String? _validatorConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

Future<void> _signUserUp() async {
  try {
    final List<ConnectivityResult> connectivityResult =
          await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      if (mounted) {
        showMessage(
          context: context,
          message: "No internet connection. Please check your connection.",
          duration: Duration(milliseconds: 1500),
          typeColor: AnimatedSnackBarType.error,
        );
      }
    } else {
      if (_formKey.currentState!.validate()) {
        try {
          UserCredential userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          );

          // Get the user's UID and email
          String uid = userCredential.user!.uid;
          String email = userCredential.user!.email!;

          // Save to Firestore
          await FirebaseFirestore.instance.collection('users').doc(uid).set({
            'uid': uid,
            'email': email,
            'createdAt': FieldValue.serverTimestamp(),
          });

          if (mounted) {
            showMessage(
              context: context,
              message: "Signup successful!",
              duration: Duration(milliseconds: 1500),
              typeColor: AnimatedSnackBarType.success,
            );
          }
        } on FirebaseAuthException catch (e) {
          if (mounted) {
            showMessage(
              context: context,
              message: e.message ?? "An error occurred.",
              duration: Duration(milliseconds: 1500),
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
            duration: Duration(milliseconds: 1500),
            typeColor: AnimatedSnackBarType.error,
          );
        }
      }
    }
  } on PlatformException catch (e) {
    if (mounted) {
      showMessage(
          context: context,
          duration: Duration(milliseconds: 1500),
          message: e.code.toString(),
          typeColor: AnimatedSnackBarType.error);
    }
  }
}

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
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
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "images/signup.png",
                          height: 200,
                          width: 200,
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Color(0xff1a1a1a)),
                        hintText: "Enter your Email",
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
                      validator: validateEmail,
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      // keyboardType: TextInputType.visiblePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: "Enter your Password",
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
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 25),
                    TextFormField(
                      // keyboardType: TextInputType.visiblePassword,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: "Re-enter your Password",
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
                      validator: _validatorConfirmPassword,
                    ),
                    const SizedBox(height: 50),
                    ElevatedButton(
                      onPressed: () {
                        _signUserUp();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff77abb6),
                        foregroundColor: const Color(0xff000000),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(double.infinity, 50),
                        elevation: 4,
                      ),
                      child: const Text('Create Account'),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: "Poppins",
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
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
                          child: const Text(
                            "Sign in here!",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 12.5,
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
      ),
    );
  }
}
