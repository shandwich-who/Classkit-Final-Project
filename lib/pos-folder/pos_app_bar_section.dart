import 'package:flutter/material.dart';

class PosAppBarSection extends StatefulWidget implements PreferredSizeWidget {
  const PosAppBarSection({super.key});

  @override
  State<PosAppBarSection> createState() => _PosAppBarSectionState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PosAppBarSectionState extends State<PosAppBarSection> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text(
        "Class Kit",
        style: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.white,
    );
  }
}
