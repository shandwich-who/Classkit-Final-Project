import 'package:finals/firebase_options.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:finals/splash-screen-folder/splash_screen_scaffold.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FluroRouterSetup.setupRoutes();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    return SplashScreenScaffold();
  }
}
