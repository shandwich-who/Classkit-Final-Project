import 'package:finals/inventory-folder/inventory_fab.dart';
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
        body: InventorySection(),
        floatingActionButton: FloatActButton(),
        ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
