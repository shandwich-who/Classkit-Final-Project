import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pretty_animated_buttons/pretty_animated_buttons.dart';

class FloatActButton extends StatefulWidget {
  const FloatActButton({super.key});

  @override
  State<FloatActButton> createState() => _FloatActButtonState();
}

class _FloatActButtonState extends State<FloatActButton> {
  void addNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return const DialogBox();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        addNewTask();
      },
      // backgroundColor: Colors.green[700],
      backgroundColor: Colors.blue[900],
      child: Icon(
        Icons.add,
        size: 40,
        color: Colors.white,
      ),
    );
  }
}

class DialogBox extends StatefulWidget {
  const DialogBox({super.key});

  @override
  State<DialogBox> createState() => _DialogBoxState();
}

class _DialogBoxState extends State<DialogBox>
    with SingleTickerProviderStateMixin {
  Widget textFormField({
    required String? labelText,
    required TextInputType? keyboardType,
  }) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: TextFormField(
            keyboardType: keyboardType!,
            decoration: InputDecoration(
              labelText: labelText!,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color(0xffe7ecef),
      title: const Text(
        "Add Items",
        textAlign: TextAlign.center,
      ),
      content: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        height: 320,
        width: 200,
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              textFormField(
                labelText: "Id",
                keyboardType: TextInputType.number,
              ),
              textFormField(
                labelText: "Name",
                keyboardType: TextInputType.text,
              ),
              textFormField(
                labelText: "Price",
                keyboardType: TextInputType.number,
              ),
              textFormField(
                labelText: "Quantity",
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 30,
              ),
              NewButton(vCallBack1: addFunc,vCallBack2:  cancelFumc,btn1: "Cancel",btn2: "Add",)
            ],
          ),
        ),
      ),
    );
  }
}

void addFunc (){

}
void cancelFumc(){

}

class NewButton extends StatelessWidget {
  final String? btn1;
  final String? btn2;
  final VoidCallback? vCallBack1; 
  final VoidCallback? vCallBack2; 

  const NewButton({super.key, required this.vCallBack1, required this.vCallBack2, required this.btn1, this.btn2});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Center(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PrettyNeumorphicButton(label: btn1!, onPressed: () => vCallBack1!,duration: Durations.short4,borderRadius: 12,padding: EdgeInsets.fromLTRB(20,15,20,15), labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                PrettyNeumorphicButton(label: btn2!, onPressed: () => vCallBack2,duration: Durations.short4,borderRadius: 12,padding: EdgeInsets.fromLTRB(20,15,20,15), labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}






