import 'package:get/get.dart';
import 'package:mynewsapp/domain/repositories/favorites_repository.dart';
import 'package:mynewsapp/features/news_detail/news_detail_controller.dart';

class NewsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NewsDetailController>(
      () => NewsDetailController(favoritesRepository: Get.find<FavoritesRepository>()),
    );
  }
}
