import 'package:finals/pos-folder/pos_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PosScaffold extends StatelessWidget {
  const PosScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   const SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.white,
        
    //     statusBarColor: Colors.transparent,
    //     statusBarIconBrightness: Brightness.dark,
    //   ),
    // );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: PosSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
