import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'inventory_section.dart';

class InventoryScaffold extends StatelessWidget {
  const InventoryScaffold({super.key});

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
      home: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,

        body: const InventorySection(),
        floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Action for the floating button
          print("Add new item clicked");
        },
        child: const Icon(Icons.add),
      ),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
