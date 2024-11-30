import 'package:flutter/material.dart';

class PosSection extends StatefulWidget implements PreferredSizeWidget {
  const PosSection({super.key});

  @override
  State<PosSection> createState() => _PosSectionState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PosSectionState extends State<PosSection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ClipOval(
                //   child: Image.asset(
                //     'classkit.jpg',
                //     width: 200.0,
                //     height: 200.0,
                //     fit: BoxFit.cover,
                //   ),
                // ),
                SizedBox(height: 16.0),
                Text(
                  'Dashboard',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32.0),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2, // Two widgets per row
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 1.0, // Square widgets
              children: [
                SupplyWidget(
                  icon: Icons.create,
                  label: 'Pens',
                  backgroundColor: Colors.grey.shade600,
                  textColor: Colors.white,
                ),
                SupplyWidget(
                  icon: Icons.book,
                  label: 'Notebooks',
                  backgroundColor: Colors.grey.shade600,
                  textColor: Colors.white,
                ),
                SupplyWidget(
                  icon: Icons.description,
                  label: 'Papers',
                  backgroundColor: Colors.grey.shade600,
                  textColor: Colors.white,
                ),
                SupplyWidget(
                  icon: Icons.delete,
                  label: 'Erasers',
                  backgroundColor: Colors.grey.shade600,
                  textColor: Colors.white,
                ),
                SupplyWidget(
                  icon: Icons.more_horiz,
                  label: 'Others',
                  backgroundColor: Colors.grey.shade600,
                  textColor: Colors.white,
                ),
                SupplyWidget(
                  icon: Icons.inventory,
                  label: 'Inventory',
                  backgroundColor: Colors.grey.shade600,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SupplyWidget extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color textColor;

  const SupplyWidget({super.key, 
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        // Add your button press logic here
      },
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.all(16.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 48.0, // Larger icon
            color: textColor,
          ),
          const SizedBox(height: 12.0),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 16.0, // Larger text
              fontWeight: FontWeight.normal,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
