import 'package:finals/inventory-folder/inventory_scaffold.dart';
import 'package:finals/pos-folder/pos_scaffold.dart';
import 'package:finals/settings-folder/settings_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardScaffold extends StatefulWidget {
  const DashboardScaffold({super.key});
  @override
  State<DashboardScaffold> createState() => _DashboardScaffoldState();
}
class _DashboardScaffoldState extends State<DashboardScaffold> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);

  final List<LinearGradient> _tabGradient = [
    const LinearGradient(
      colors: [Color(0xffFF9A9E), Color(0xffFAD0C4)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    const LinearGradient(
      colors: [Color(0xff89F7FE), Color(0xff66A6FF)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    const LinearGradient(
      colors: [Color(0xff7F7FD5), Color(0xff91EAE4)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
  ];

  final List<Widget> _pages = [
    const PosScaffold(),
    const SettingsScaffold(),
    const InventoryScaffold(),
  ];

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500), 
      curve: Curves.easeInOut,
    );
  }

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
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          children: _pages,
        ),
        bottomNavigationBar: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
              child: GNav(
                tabBackgroundGradient: _tabGradient[_selectedIndex],
                backgroundColor: Colors.white,
                color: Colors.black54,
                activeColor: Colors.black,
                curve: Curves.easeOutExpo,
                duration: const Duration(milliseconds: 900),
                tabBorderRadius: 16,
                gap: 8,
                selectedIndex: _selectedIndex,
                onTabChange: _onTabChange,
                padding: const EdgeInsets.all(16),
                tabs: const [
                  GButton(
                    icon: Icons.point_of_sale_sharp,
                    text: "Pos",
                  ),
                  GButton(icon: Icons.settings_rounded, text: "Settings"),
                  GButton(
                    icon: Icons.inventory_2_outlined,
                    text: "Inventory",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
