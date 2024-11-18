import 'package:finals/pos-folder/pos_app_bar_section.dart';
import 'package:flutter/material.dart';

class PosScaffold extends StatelessWidget {
  const PosScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: PosAppBarSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
