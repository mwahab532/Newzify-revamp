import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/app/routes/app_pages.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';

/// Root GetMaterialApp. Was the `Newszify` widget in main.dart.
class Newszify extends StatelessWidget {
  const Newszify({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "News App",
      theme: FlexThemeData.light(scheme: FlexScheme.blackWhite),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.blackWhite),
      themeMode: ThemeMode.system,
      initialRoute: AppRoutes.splash,
      getPages: AppPages.pages,
    );
  }
}
