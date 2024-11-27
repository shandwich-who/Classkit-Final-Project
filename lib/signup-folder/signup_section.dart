import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finals/auth-folder/auth_section.dart';
import 'package:finals/login-folder/login_scaffold.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:finals/text-form-field-validator-folder/validator_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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

  String? validatorConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  Future<void> _signUserUp() async {
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    Future<void> _showMessage(String message, AnimatedSnackBarType type) async {
      if (mounted) {
        showMessage(
          context: context,
          message: message,
          duration: const Duration(milliseconds: 1500),
          typeColor: type,
        );
        Navigator.pop(context);
      }
    }

    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        await _showMessage(
            "No internet connection. Please check your connection.",
            AnimatedSnackBarType.error);
        return;
      }

      if (_formKey.currentState?.validate() ?? false) {
        try {
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: _emailController.text,
            password: _confirmPasswordController.text,
          );

          await _showMessage(
              "Successfully Created an Account", AnimatedSnackBarType.success);
          if (mounted){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AuthSection()),
            );
          }
        } on FirebaseAuthException catch (e) {
          String message = e.code.toString();
          await _showMessage(message, AnimatedSnackBarType.error);
        }
      } else {
        await _showMessage(
          "There was an error creating your account. Please try again later.",
          AnimatedSnackBarType.error,
        );
      }
    } catch (e) {
      await _showMessage(
          'An error occurred. Please try again.', AnimatedSnackBarType.error);
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
                      validator: validatorConfirmPassword,
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
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScaffold(),
                              ),
                            );
                          },
                          child: const Text(
                            "Sign in here!",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Poppins",
                              fontSize: 12,
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
