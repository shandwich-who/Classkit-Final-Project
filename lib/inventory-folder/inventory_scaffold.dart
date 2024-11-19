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
        // appBar: InventoryAppBar(),
        appBar: AppBar(
          centerTitle: true,
          title: Text("Inventory"),
        ), //temporary
        body: const InventorySection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
