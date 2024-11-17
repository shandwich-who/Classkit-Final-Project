import 'package:finals/login-folder/login_scaffold.dart';
import 'package:flutter/material.dart';

class ForgotPasswordSection extends StatefulWidget {
  const ForgotPasswordSection({super.key});

  @override
  State<ForgotPasswordSection> createState() => _ForgotPasswordSectionState();
}

class _ForgotPasswordSectionState extends State<ForgotPasswordSection> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController otpPasswordController =
      TextEditingController();
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                      children: [
                        IconButton(onPressed: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScaffold()),
                          );
                        }, icon: const Icon(Icons.arrow_back_rounded))
                      ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "images/forgot.png",
                        height: 220,
                        width: 220,
                      ),
                    ],
                  ),
                  TextField(
                    controller: emailController,
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
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
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        height: 50,
                        width: 200,
                        child: TextField(
                          controller: otpPasswordController,
                          decoration: InputDecoration(
                            labelText: 'OTP',
                            hintText: "Enter your OTP",
                            hintStyle: const TextStyle(color: Colors.grey ,fontSize: 13),
                            labelStyle:
                                const TextStyle(color: Color(0xff1a1a1a), fontSize: 13),
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
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          //todo send otp here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xff1a1a1a),
                          foregroundColor:  Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ), //elevation: 4,
                          minimumSize: const Size(10, 45),
                        ),
                        child: const Text("Send OTP"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Implement login logic here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff77aac7),
                      foregroundColor: const Color(0xff1a1a1a),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      minimumSize: const Size(double.infinity, 50),
                      elevation: 4,
                    ),
                    child: const Text('Reset Password'),
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
