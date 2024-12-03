import 'package:finals/splash-screen-folder/splash_screen_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreenScaffold extends StatefulWidget {
  const SplashScreenScaffold({super.key});

  @override
  State<SplashScreenScaffold> createState() => _SplashScreenScaffoldState();
}

class _SplashScreenScaffoldState extends State<SplashScreenScaffold> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(

        backgroundColor: Colors.white,
        body: SplashScreenSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
    
  }
}