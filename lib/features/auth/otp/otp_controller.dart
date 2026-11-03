import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';
import 'package:mynewsapp/core/network/result.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';

class OtpController extends GetxController {
  final AuthRepository _repo;
  OtpController({required AuthRepository repository}) : _repo = repository;

  final otpController = TextEditingController();
  final isVerifying = false.obs;
  late final String email;

  @override
  void onInit() {
    super.onInit();
    email = (Get.arguments as String?) ?? '';
  }

  Future<void> resendOtp() async {
    final result = await _repo.sendOtp(email);
    switch (result) {
      case Ok():
        Get.snackbar('Success', 'OTP Send Successfully ✅');
      case Err(:final error):
        Get.snackbar('Error', error.userMessage);
    }
  }

  Future<void> verifyOtp() async {
    if (otpController.text.isEmpty) {
      Get.snackbar('Error', 'Please enter OTP', backgroundColor: Colors.red);
      return;
    }
    isVerifying.value = true;
    final result = await _repo.verifyOtp(otpController.text);
    isVerifying.value = false;

    switch (result) {
      case Ok(value: true):
        Get.snackbar('Success', 'Successfully Registered.', backgroundColor: Colors.green);
        Get.offAllNamed(AppRoutes.authGate);
      case Ok(value: false):
        Get.snackbar('Error', 'Invalid OTP ❌', backgroundColor: Colors.red);
      case Err(:final error):
        Get.snackbar('Error', error.userMessage, backgroundColor: Colors.red);
    }
  }

  @override
  void onClose() {
    otpController.dispose();
    super.onClose();
  }
}
