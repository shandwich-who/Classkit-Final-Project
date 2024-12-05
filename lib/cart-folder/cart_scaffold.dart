import 'package:finals/cart-folder/cart_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CartScaffold extends StatelessWidget {
  const CartScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.white,
    //     // statusBarColor: Colors.transparent,
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: CartSection(),
        

      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}

