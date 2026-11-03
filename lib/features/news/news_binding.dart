import 'package:get/get.dart';
import 'package:mynewsapp/domain/repositories/favorites_repository.dart';
import 'package:mynewsapp/domain/repositories/news_repository.dart';
import 'package:mynewsapp/features/news/news_controller.dart';

class NewsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsController>(
      () => NewsController(
        newsRepository: Get.find<NewsRepository>(),
        favoritesRepository: Get.find<FavoritesRepository>(),
      ),
    );
  }
}
