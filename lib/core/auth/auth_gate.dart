import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/core/auth/auth_service.dart';
import 'package:mynewsapp/features/app_shell/app_shell_binding.dart';
import 'package:mynewsapp/features/app_shell/app_shell_controller.dart';
import 'package:mynewsapp/features/app_shell/app_shell_view.dart';
import 'package:mynewsapp/features/auth/login/login_binding.dart';
import 'package:mynewsapp/features/auth/login/login_controller.dart';
import 'package:mynewsapp/features/auth/login/login_view.dart';

/// Was Auth/auth.dart. Renders Home or Login based on the shared
/// AuthService status stream instead of its own StreamBuilder.
///
/// Because this widget is shown directly (not routed to via
/// Get.toNamed), the normal GetPage binding never fires — so each
/// branch here is responsible for registering its own controller
/// before returning its view.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Get.find<AuthService>();
    return Scaffold(
      body: Obx(() {
        switch (auth.status.value) {
          case AuthStatus.unknown:
            return const Center(child: CircularProgressIndicator());
          case AuthStatus.authenticated:
            if (!Get.isRegistered<AppShellController>()) {
              AppShellBinding().dependencies();
            }
            return const AppShellView();
          case AuthStatus.unauthenticated:
            if (!Get.isRegistered<LoginController>()) {
              LoginBinding().dependencies();
            }
            return const LoginView();
        }
      }),
    );
  }
}