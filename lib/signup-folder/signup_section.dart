// import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:finals/login-folder/login_scaffold.dart';
import 'package:finals/switch-tab-folde/global_function.dart';
import 'package:flutter/material.dart';

class SignupSection extends StatefulWidget {
  const SignupSection({super.key});

  @override
  State<SignupSection> createState() => _SignupSectionState();
}

class _SignupSectionState extends State<SignupSection> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  String? _validatorConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    } else if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
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
                      controller: emailController,
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
                      controller: passwordController,
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
                      controller: confirmPasswordController,
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
                        if (_formKey.currentState?.validate() ?? false) {
                          signUserUp(email: emailController.text, password: passwordController.text, confirmPassword: confirmPasswordController.text, context: context);
                          
                        } else {
                          showErrorMessage(context: context, message: "Please review the form and correct any highlighted errors.", typecolor: AnimatedSnackBarType.error, duration: Durations.short4);
                        }
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
