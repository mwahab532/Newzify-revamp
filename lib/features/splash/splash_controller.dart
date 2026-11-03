import 'dart:async';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';

class SplashController extends GetxController {
  final showSpinner = false.obs;
  final showNoInternetDialog = false.obs;

  @override
  void onReady() {
    super.onReady();
    _initializeApp();
  }

  Future<bool> _checkInternetConnection() async {
    try {
      final connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) return false;
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException {
      return false;
    }
  }

  Future<void> _initializeApp() async {
    final isConnected = await _checkInternetConnection();
    if (isConnected) {
      showSpinner.value = true;
      showNoInternetDialog.value = false;
      Timer(const Duration(seconds: 2), () {
        Get.offAllNamed(AppRoutes.authGate);
      });
    } else {
      showNoInternetDialog.value = true;
    }
  }

  void retry() {
    showSpinner.value = false;
    _initializeApp();
  }
}
