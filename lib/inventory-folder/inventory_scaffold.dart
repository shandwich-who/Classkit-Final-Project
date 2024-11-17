import 'package:finals/inventory-folder/inventory_section.dart';
import 'package:flutter/material.dart';

class InventoryScaffold extends StatelessWidget {
  const InventoryScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        resizeToAvoidBottomInset: true,
        body: InventorySection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
