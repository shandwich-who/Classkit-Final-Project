// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../auth-folder/auth_scaffold.dart';

// import 'package:lottie/lottie.dart';

// class SplashScreenSection extends StatelessWidget {
//   const SplashScreenSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedSplashScreen(
//       splash: Center(

//         child: Lottie.asset('assets/animation/one.json'),
//       ),
//       splashIconSize: 180,
//       nextScreen: const LoginScaffold(),
//       duration: 1000,
//       splashTransition: SplashTransition.fadeTransition,
//       backgroundColor: Colors.white,
//     );
//   }
// }

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
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.push((context),
          MaterialPageRoute(builder: (context) => const AuthScaffold()));
    });
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
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
              // Icon(
              //   Icons.diamond,
              //   size: 80,
              //   color: Colors.white,
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   "Hello World",
              //   style: TextStyle(color: Colors.white, fontSize: 20),
              // ),
              Image.asset(
                "images/orig.png",
                height: 220,
                width: 220,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
