import 'package:finals/dashboard-folder/dashboard_function.dart';
import 'package:finals/dashboard-folder/dashboard_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({super.key});

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
        // backgroundColor: Colors.lightBlueAccent,
        resizeToAvoidBottomInset: true,
        // appBar: PosAppBarSection(),
        body: Obx(() => controlNavBar.pages[controlNavBar.index.value]),
        bottomNavigationBar: const DashboardSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
