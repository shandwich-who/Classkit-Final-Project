import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:finals/signup-folder/signup_scaffold.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../auth-folder/auth_section.dart';
import '../forget-password-folder/forgot_password_scaffold.dart';
import '../show-message-folder/show_message.dart';
import '../text-form-field-validator-folder/validator_section.dart';

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
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

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

      // Check if the widget is still mounted before showing the message
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
  void dispose() {
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
                          keyboardType: TextInputType.visiblePassword,
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ForgotPasswordScaffold()),
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
                            if (_formKey.currentState?.validate() ?? false) {
                              _signUserIn;

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const AuthSection()));
                            } else {
                              showMessage(
                                context: context,
                                message:
                                    "Hmm, something's not quite right. Please check your login details and try again.",
                                duration: const Duration(milliseconds: 1500),
                                typeColor: AnimatedSnackBarType.error,
                              );
                            }
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
                      // try {
                      //   final user = await UserController.loginWithGoogle();
                      //   if (user != null) {
                      //     if (mounted) {
                      //       Navigator.of(context).push(MaterialPageRoute(
                      //         builder: (context) => const AuthSection(),
                      //       ));
                      //     }
                      //   }
                      // } on FirebaseAuthException catch (e) {
                      //   String mess = e.code;
                      //   if (mounted) {
                      //     showMessage(
                      //       context: context,
                      //       message: mess,
                      //       duration: const Duration(milliseconds: 1500),
                      //       typeColor: AnimatedSnackBarType.error,
                      //     );
                      //   }
                      // }
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
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignupScaffold()),
                          );
                        },
                        child: const Text(
                          "Sign up here!",
                          style: TextStyle(
                            color: Color(0xff000000),
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
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
