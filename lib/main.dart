import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/app/app.dart';
import 'package:mynewsapp/app/bindings/initial_binding.dart';
import 'package:mynewsapp/core/observability/app_error_handler.dart';
import 'package:mynewsapp/firebase_options.dart';

/// Bootstrap only: init services, wire the three global error funnels, then
/// runApp. All DI now goes through InitialBinding rather than MultiProvider.
void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    await InitialBinding().dependenciesAsync();
    Get.find<AppErrorHandler>().install();

    runApp(const Newszify());
  }, (error, stack) {
    Get.find<AppErrorHandler>()
        .report(error, stack, context: 'zone', fatal: true);
  });
}
