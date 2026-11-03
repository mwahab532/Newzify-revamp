import 'package:get/get.dart';
import 'package:mynewsapp/domain/repositories/news_repository.dart';
import 'package:mynewsapp/features/categories/categories_controller.dart';

class CategoriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoriesController>(
      () => CategoriesController(repository: Get.find<NewsRepository>()),
    );
  }
}
