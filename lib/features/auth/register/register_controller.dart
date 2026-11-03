import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';
import 'package:mynewsapp/core/network/result.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';

class RegisterController extends GetxController {
  final AuthRepository _repo;
  RegisterController({required AuthRepository repository}) : _repo = repository;

  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final registerBtnController = RoundedLoadingButtonController();
  final isPasswordVisible = false.obs;
  final isSendingOtp = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;

  Future<void> sendOtp() async {
    isSendingOtp.value = true;
    final result = await _repo.sendOtp(emailController.text);
    isSendingOtp.value = false;
    switch (result) {
      case Ok():
        Get.snackbar('Success', 'OTP Send Successfully ✅');
      case Err(:final error):
        Get.snackbar('Error', error.userMessage);
    }
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      registerBtnController.reset();
      return;
    }
    final result = await _repo.registerWithEmailPassword(
      username: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    switch (result) {
      case Ok():
        Get.toNamed(AppRoutes.otp, arguments: emailController.text);
      case Err(:final error):
        Get.snackbar('Error', error.userMessage, backgroundColor: Colors.red);
    }
    registerBtnController.reset();
  }

  @override
  void onClose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
