import 'package:flutter/material.dart';

class PosAppBarSection extends StatelessWidget implements PreferredSizeWidget {
  const PosAppBarSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Class Kit"),
    );
  }

  @override
  Size get preferredSize =>
      const Size.fromHeight(kToolbarHeight); // Set the app bar's height
}
