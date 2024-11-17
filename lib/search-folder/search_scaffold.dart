import 'package:finals/search-folder/search_section.dart';
import 'package:flutter/material.dart';

class SearchScaffold extends StatelessWidget {
  const SearchScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Scaffold(
        
        resizeToAvoidBottomInset: true,
       body: SearchSection(),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}