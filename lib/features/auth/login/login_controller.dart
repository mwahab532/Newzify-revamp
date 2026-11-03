import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rounded_loading_button_plus/rounded_loading_button.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';
import 'package:mynewsapp/core/network/result.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';

class LoginController extends GetxController {
  final AuthRepository _repo;
  LoginController({required AuthRepository repository}) : _repo = repository;

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final loginBtnController = RoundedLoadingButtonController();
  final navigateBtnController = RoundedLoadingButtonController();
  final isPasswordVisible = false.obs;

  void togglePasswordVisibility() => isPasswordVisible.value = !isPasswordVisible.value;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      loginBtnController.reset();
      navigateBtnController.reset();
      return;
    }
    final result = await _repo.signInWithEmailPassword(
      emailController.text,
      passwordController.text,
    );
    switch (result) {
      case Ok():
        emailController.clear();
        passwordController.clear();
        Get.snackbar('Success', 'Successfully Login.', backgroundColor: Colors.green);
        Get.offAllNamed(AppRoutes.authGate);
      case Err(:final error):
        Get.snackbar('Error', error.userMessage, backgroundColor: Colors.red);
    }
    loginBtnController.reset();
  }

  Future<void> signInWithGoogle() async {
    final result = await _repo.signInWithGoogle();
    switch (result) {
      case Ok():
        Get.snackbar('Success', 'SignIn Successful', backgroundColor: Colors.green);
        Get.offAllNamed(AppRoutes.authGate);
      case Err(:final error):
        Get.snackbar('Error', error.userMessage, backgroundColor: Colors.red);
    }
  }

  void goToRegister() {
    Get.toNamed(AppRoutes.register);
    navigateBtnController.reset();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
