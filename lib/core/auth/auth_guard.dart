import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';
import 'package:mynewsapp/core/auth/auth_service.dart';

class AuthGuard extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) =>
      Get.find<AuthService>().status.value == AuthStatus.authenticated
          ? null
          : const RouteSettings(name: AppRoutes.login);
}
