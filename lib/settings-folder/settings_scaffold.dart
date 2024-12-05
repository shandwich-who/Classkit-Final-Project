import 'package:finals/settings-folder/settings_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SettingsScaffold extends StatelessWidget {
  const SettingsScaffold({super.key});

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
        body: SettingsSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
