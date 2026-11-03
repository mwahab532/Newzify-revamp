import 'package:get/get.dart';

class AppShellController extends GetxController {
  final currentIndex = 0.obs;

  void changeTab(int i) {
    if (i == currentIndex.value) return;
    currentIndex.value = i;
  }
}
