import 'package:finals/switch-tab-folde/global_function.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashboardSection extends StatefulWidget {
  const DashboardSection({super.key});

  @override
  State<DashboardSection> createState() => _DashboardSectionState();
}

class _DashboardSectionState extends State<DashboardSection> {

  @override
  Widget build(BuildContext context) { 

    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:15.0, vertical: 20),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.lightBlue,
          tabBackgroundColor: const Color(0xff1a1a1a), 
          // tabShadow: [BoxShadow(color: Color(0xff1a1a1a).withOpacity(0.5),blurRadius: 8)],
          curve: Curves.easeOutExpo,
          duration: const Duration(milliseconds: 900),
          tabBorderRadius: 20,
          gap: 8, 
          // selectedIndex: 1,
          onTabChange: (index) {
            print(index);
            controlNavBar.index.value = index;
            controlNavBar.pages[index];

          },
          padding: const EdgeInsets.all(16),
          tabs: const [
          GButton(
            icon: Icons.point_of_sale_rounded,
            text: "Pos",
          ),
          GButton(
            icon: Icons.search,
            text: "Search",
          ),
          GButton(
            icon: Icons.inventory_2_rounded,
            text: "Inventory",
          ),
        ]),
      ),
    );

  
  }
}
