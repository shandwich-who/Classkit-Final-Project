import 'package:finals/switch-tab-folde/global_function.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SearchSection extends StatelessWidget {
  const SearchSection({super.key});
  
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(onPressed: (){
            signUserOut(context: context);
          }, icon: const Icon(Icons.logout)),
          Text("Welcome ${user.email}")

        ],
      ));
  }
}
