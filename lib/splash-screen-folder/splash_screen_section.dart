import 'package:finals/auth-folder/auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreenSection extends StatefulWidget {
  const SplashScreenSection({super.key});

  @override
  State<SplashScreenSection> createState() => _SplashScreenSectionState();
}

class _SplashScreenSectionState extends State<SplashScreenSection>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..forward();

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

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
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  // @override
  // void initState() {
  //   super.initState();

  //   // Enable immersive mode (hides status and navigation bars)
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
  //       overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);

  //   // Change the status bar to white (light icons)
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.white, // Set the status bar color to white
  //     statusBarIconBrightness: Brightness
  //         .dark, // Set icons to dark for visibility on white background
  //     systemNavigationBarColor:
  //         Colors.white, // Optional: Set navigation bar color to white
  //     systemNavigationBarIconBrightness:
  //         Brightness.dark, // Optional: Set icons to dark for the navigation bar
  //   ));
  //   _controller = AnimationController(
  //     vsync: this,
  //     duration: const Duration(seconds: 2),
  //   )..forward();

  //   _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

  //   Future.delayed(const Duration(milliseconds: 3000), () {
  //     if (mounted) {
  //       Navigator.pushReplacement(
  //         context,
  //         MaterialPageRoute(builder: (context) => const AuthScaffold()),
  //       );
  //     }
  //   });
  // }

  // @override
  // void dispose() {
  //   // Reset to default system UI when no longer needed
  //   SystemChrome.setEnabledSystemUIMode(
  //       SystemUiMode.edgeToEdge); // Shows both status and navigation bars

  //   // Optionally, reset the status bar color to default when disposing
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent, // Reset to default color
  //     statusBarIconBrightness: Brightness.light, // Reset icon brightness
  //     systemNavigationBarColor:
  //         Colors.black, // Reset navigation bar color to default
  //     systemNavigationBarIconBrightness:
  //         Brightness.light, // Reset navigation bar icons color
  //   ));

  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

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
              FadeTransition(
                opacity: _fadeAnimation,
                child: Image.asset(
                  "images/orig.png",
                  height: screenHeight * 0.3,
                  width: screenHeight * 0.3,
                ),
              ),
              const SizedBox(height: 20),
              SpinKitPouringHourGlassRefined(
                color: Color(0xff000000),
                size: 50.0,
              ),
              const SizedBox(height: 20),
              const Text(
                "Loading, please wait...",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
