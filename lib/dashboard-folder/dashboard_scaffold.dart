import 'package:finals/dashboard-folder/dashboard_section.dart';
import 'package:finals/switch-tab-folde/global_function.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DashboardScaffold extends StatelessWidget {
  const DashboardScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        // statusBarColor: Colors.transparent,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // backgroundColor: Colors.white70,
        resizeToAvoidBottomInset: true,
        // appBar: PosAppBarSection(),
        body: Obx(() => controlNavBar.pages[controlNavBar.index.value]),
        bottomNavigationBar: const DashboardSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
