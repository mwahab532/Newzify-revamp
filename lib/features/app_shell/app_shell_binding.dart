import 'package:get/get.dart';
import 'package:mynewsapp/features/app_shell/app_shell_controller.dart';
import 'package:mynewsapp/features/categories/categories_binding.dart';
import 'package:mynewsapp/features/news/news_binding.dart';
import 'package:mynewsapp/features/profile/profile_binding.dart';

class AppShellBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AppShellController());
    NewsBinding().dependencies();
    CategoriesBinding().dependencies();
    ProfileBinding().dependencies();
  }
}
