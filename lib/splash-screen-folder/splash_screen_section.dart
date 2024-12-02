import 'package:finals/auth-folder/auth_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Add this import

class SplashScreenSection extends StatefulWidget {
  const SplashScreenSection({super.key});

  @override
  State<SplashScreenSection> createState() => _SplashScreenSectionState();
}

class _SplashScreenSectionState extends State<SplashScreenSection>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    // Set immersive mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Navigate to AuthScaffold after a delay
    Future.delayed(const Duration(milliseconds: 3000), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AuthScaffold()),
        );
      }
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xffffe3d8), Color(0xffeaf9e7)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "images/orig.png", // Ensure this image path is correct
                height: 220,
                width: 220,
              ),
              const SizedBox(height: 20), // Added SizedBox for spacing
              SpinKitSquareCircle(
                color: Colors.grey[900],
                size: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
