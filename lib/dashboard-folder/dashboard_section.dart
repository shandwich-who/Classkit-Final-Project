
import 'package:finals/switch-tab-folde/global_function.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';


class DashboardSection extends StatefulWidget {
  const DashboardSection({super.key});

  @override
  State<DashboardSection> createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {
  // final List<Color> _tabColors = [
  //   Colors.lightBlueAccent,
  //   Colors.white,
  //   Colors.orangeAccent,
  // ];
  // final List<Color> _activeColor = [Colors.white, Colors.black, Colors.white];

  final List<LinearGradient> _tabGradient = [
    // Gradient for POS (Index 0)
    const LinearGradient(
      colors: [
        Color(0xffFF9A9E),
        Color(0xffFAD0C4)
      ], // Soft pink tones for a friendly and engaging feel
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),

    // Gradient for Search (Index 1)
    const LinearGradient(
      colors: [
        Color(0xff89F7FE),
        Color(0xff66A6FF)
      ], // Cool blue tones for clarity and focus
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),

    // Gradient for Inventory (Index 2)
    const LinearGradient(
      colors: [
        Color(0xff7F7FD5),
        // Color(0xff86A8E7),
        Color(0xff91EAE4)
      ], // Muted blues with subtle transitions for professionalism
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,
    ),
  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set background color based on selected tab
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
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
          child: GNav(
            // activeColor: _activeColor[_selectedIndex],
            tabBackgroundGradient: _tabGradient[_selectedIndex],
            // activeColor: Colors.grey.shade900,
            // tabBackgroundColor: Colors.lightBlueAccent,
            backgroundColor: Colors.white,
            color: Colors.black54,
            activeColor: Colors.black,
            curve: Curves.easeOutExpo,
            duration: const Duration(milliseconds: 900),
            tabBorderRadius: 16,
            gap: 8,
            selectedIndex: _selectedIndex,
            // selectedIndex: 0,
            onTabChange: (index) {
              setState(() {
                _selectedIndex = index;
                controlNavBar.index.value = index;
                controlNavBar.pages[index]; // Update the selected index
              });
            },
            padding: const EdgeInsets.all(16),
            tabs: const [
              GButton(
                icon: Icons.point_of_sale_sharp,
                text: "Pos",
              ),
              // GButton(
              //   icon: Icons.search,
              //   text: "Search",
              // ),
              GButton(icon: Icons.settings_rounded, text: "Settings"),
              GButton(
                icon: Icons.inventory_2_outlined,
                text: "Inventory",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
