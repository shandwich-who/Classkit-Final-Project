import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:finals/service-folder/firestore.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:finals/text-form-field-validator-folder/validator_section.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

final TextEditingController _idController = TextEditingController();
final TextEditingController _nameController = TextEditingController();
final TextEditingController _priceController = TextEditingController();
final TextEditingController _quantityController = TextEditingController();
final _formKey = GlobalKey<FormState>();

class FloatActButton extends StatefulWidget {
  const FloatActButton({super.key});

  @override
  State<FloatActButton> createState() => _FloatActButtonState();
}

class _FloatActButtonState extends State<FloatActButton> {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showCustomDialog(context);
      },
      backgroundColor: Colors.blue[900],
      child: Icon(
        Icons.add,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}

void showCustomDialog(BuildContext context) {
  Widget textFormField({
    required String? labelText,
    required TextInputType? keyboardType,
    required TextEditingController txtController,
    required String? Function(String?)? validator,
  }) {
    return Column(
      children: [
        TextFormField(
          validator: validator,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          controller: txtController,
          keyboardType: keyboardType!,
          decoration: InputDecoration(
            labelText: labelText!,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ],
    );
  }

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Add Item",
          textAlign: TextAlign.center,
        ),
        titlePadding: EdgeInsets.fromLTRB(30, 30, 30, 15),
        shadowColor: Colors.grey,
        surfaceTintColor: Colors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: SizedBox(
          height: 300,
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  textFormField(
                    validator: validateId,
                    txtController: _idController,
                    labelText: "Item ID",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  textFormField(
                    validator: validateName,
                    txtController: _nameController,
                    labelText: "Name",
                    keyboardType: TextInputType.text,
                  ),
                  SizedBox(height: 20),
                  textFormField(
                    txtController: _priceController,
                    validator: validatePrice,
                    labelText: "Price",
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 20),
                  textFormField(
                    txtController: _quantityController,
                    validator: validateQuantity,
                    labelText: "Quantity",
                    keyboardType: TextInputType.number,
                  ),
                  // SizedBox(height: 10),
                  // NewButton(),
                ],
              ),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: NewButton(),
          )
        ],
      );
    },
  );
}

class NewButton extends StatefulWidget {
  const NewButton({super.key});

  @override
  State<NewButton> createState() => _NewButtonState();
}

class _NewButtonState extends State<NewButton> {
  final FirestoreService _fireStoreService = FirestoreService();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PrettyNeumorphicButton(
                label: "Cancel",
                onPressed: () {
                  Future.delayed(Duration(milliseconds: 500), () {
                    try {
                      _idController.clear();
                      _nameController.clear();
                      _priceController.clear();
                      _quantityController.clear();

                      Navigator.of(mounted ? context : context,
                              rootNavigator: true)
                          .pop();
                    } catch (e) {
                      showMessage(
                          context: mounted ? context : context,
                          duration: Duration(milliseconds: 1500),
                          message: e.toString(),
                          typeColor: AnimatedSnackBarType.error);
                    }
                  });
                },
                duration: Durations.medium1,
                borderRadius: 12,
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              PrettyNeumorphicButton(
                label: "Add",
                onPressed: () {
                  Future.delayed(Duration(milliseconds: 500), () {
                    try {
                      if (_formKey.currentState!.validate()) {
                        _fireStoreService.createData(
                          int.parse(_idController.text),
                          _nameController.text,
                          double.parse(_priceController.text),
                          int.parse(_quantityController.text),
                        );
                        showMessage(
                            context: mounted ? context : context,
                            duration: Duration(milliseconds: 1500),
                            message: "Already Added",
                            typeColor: AnimatedSnackBarType.success);

                        _idController.clear();
                        _nameController.clear();
                        _priceController.clear();
                        _quantityController.clear();
                        Navigator.of(mounted ? context : context,
                                rootNavigator: true)
                            .pop();
                      } else {
                        showMessage(
                            context: mounted ? context : context,
                            duration: Duration(milliseconds: 1500),
                            message:
                                "There are some errors please fix it before proceeding",
                            typeColor: AnimatedSnackBarType.error);
                      }
                    } catch (e) {
                      showMessage(
                          context: mounted ? context : context,
                          duration: Duration(milliseconds: 1500),
                          message: e.toString(),
                          typeColor: AnimatedSnackBarType.error);
                    }
                  });
                },
                duration: Durations.short4,
                borderRadius: 12,
                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                labelStyle:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
