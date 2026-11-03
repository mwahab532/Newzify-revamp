import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:mynewsapp/features/app_shell/app_shell_controller.dart';
import 'package:mynewsapp/features/categories/categories_view.dart';
import 'package:mynewsapp/features/news/news_view.dart';
import 'package:mynewsapp/features/profile/profile_view.dart';

/// Was views/Home.dart. IndexedStack keeps every tab's state alive across
/// switches — tab changes never push a route (see §15).
class AppShellView extends GetView<AppShellController> {
  const AppShellView({super.key});

  static const _tabs = [NewsView(), CategoriesView(), ProfileView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => IndexedStack(index: controller.currentIndex.value, children: _tabs)),
      bottomNavigationBar: Obx(() => SalomonBottomBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTab,
            items: [
              SalomonBottomBarItem(icon: const Icon(Icons.home), title: const Text("Home")),
              SalomonBottomBarItem(icon: const Icon(Icons.category_sharp), title: const Text("Catagorices")),
              SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text("Profile")),
            ],
          )),
    );
  }
}
