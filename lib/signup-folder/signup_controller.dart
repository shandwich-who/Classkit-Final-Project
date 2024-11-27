import 'package:finals/loader-screeen-folder/loader-screen.dart';
import 'package:finals/network-manager-folder/network_manager.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  GlobalKey<FormState> signUpForm = GlobalKey<FormState>();

  Future<void> signUserUp() async {
    try {
      final isConnected = await NetworkManager.instance.isConnected();

      if (!isConnected) {
        LoaderScreen.stopLoading();
        return;
      }
      if (!signUpForm.currentState!.validate()) {
        LoaderScreen.stopLoading();
      }
    } on FirebaseAuthException catch (e) {
      ShowSnackBarMessage.errorSnackBar(
          title: "Oh Snap", message: e.toString());
    }
  }
}
