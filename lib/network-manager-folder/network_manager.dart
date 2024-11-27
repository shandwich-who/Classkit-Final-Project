import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finals/show-message-folder/show_message.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  final Rx<ConnectivityResult> _connectionStatus = ConnectivityResult.none.obs;

  @override
  void onInit() {
    super.onInit();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  // Updates the connection status and shows a snackbar if no connection
  Future<void> _updateConnectionStatus(List<ConnectivityResult> results) async {
    // Assuming you're just interested in the first result
    var result = results.first;

    _connectionStatus.value = result;

    if (_connectionStatus.value == ConnectivityResult.none) {
      // Show a snackbar when there's no connection
      ShowSnackBarMessage.errorSnackBar(title: "No Internet Connection");
    }
  }

  // Checks if the device is connected to the internet
  Future<bool> isConnected() async {
    try {
      var connectivityResult = await _connectivity.checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        return false;
      } else {
        return true;
      }
    } on PlatformException catch (_) {
      return false;
    }
  }

  @override
  void onClose() {
    super.onClose();
    // Cancel the connectivity subscription when the controller is disposed
    _connectivitySubscription.cancel();
  }
}
