import 'package:finals/pos-folder/pos_app_bar_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PosScaffold extends StatelessWidget {
  const PosScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        // statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        resizeToAvoidBottomInset: true,
        // appBar: PosAppBarSection(),
        // body: Center(child: Text("Point of Sale (Empty)")),
        body: PosAppBarSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
