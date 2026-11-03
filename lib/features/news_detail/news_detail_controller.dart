import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:mynewsapp/domain/repositories/favorites_repository.dart';
import 'package:mynewsapp/shared/models/article.dart';

/// Reused by news, categories, and favorites — an article is passed
/// directly as a route argument (no fetch-by-id endpoint exists for a
/// single article), which is a documented, deliberate exception to the
/// "navigate by id" rule in §4.5.
class NewsDetailController extends GetxController {
  final FavoritesRepository _favoritesRepo;
  NewsDetailController({required FavoritesRepository favoritesRepository})
      : _favoritesRepo = favoritesRepository;

  late final Article article;
  late final RxBool _isFavorite;

  @override
  void onInit() {
    super.onInit();
    article = Get.arguments as Article;
    _isFavorite = _favoritesRepo.isFavorite(article).obs;
  }

  bool get isFavorite => _isFavorite.value;
  RxBool get isFavoriteRx => _isFavorite;

  Future<void> toggleFavorite() async {
    await _favoritesRepo.toggleFavorite(article);
    _isFavorite.value = _favoritesRepo.isFavorite(article);
  }

  Future<void> openUrl() async {
    if (article.url == null) {
      Get.snackbar('Notice', 'URL not available for this article.');
      return;
    }
    final uri = Uri.parse(article.url!);
    if (!await launchUrl(uri, mode: LaunchMode.inAppWebView)) {
      Get.snackbar('Error', 'Could not launch ${article.url}');
    }
  }
}
