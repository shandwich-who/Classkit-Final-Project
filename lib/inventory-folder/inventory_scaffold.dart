import 'package:finals/inventory-folder/inventory_fab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart'; // Add this to your pubspec.yaml
import 'inventory_section.dart';

class InventoryScaffold extends StatelessWidget {
  const InventoryScaffold({super.key});

  Future<bool> _checkConnection() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return connectivityResult.contains(ConnectivityResult.none)
        ? false
        : true; // Returns true if there is a connection
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: FutureBuilder<bool>(
          future: _checkConnection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // Show a loading spinner while checking for connection
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError || !(snapshot.data ?? false)) {
              // Show an error message if no connection
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'No internet connection.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Please check your connection.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              // Show the main UI if there is a connection
              return const InventorySection();
            }
          },
        ),
        floatingActionButton: FutureBuilder<bool>(
          future: _checkConnection(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting ||
                snapshot.hasError ||
                !(snapshot.data ?? false)) {
              return Container();
            } else {
              return const FloatActButton(); // Show FAB if connected
            }
          },
        ),
      ),
      theme: ThemeData(useMaterial3: false),
    );
  }
}
