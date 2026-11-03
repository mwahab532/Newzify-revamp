import 'package:get/get.dart';
import 'package:mynewsapp/domain/repositories/favorites_repository.dart';
import 'package:mynewsapp/shared/models/article.dart';

class FavoritesController extends GetxController {
  final FavoritesRepository _repo;
  FavoritesController({required FavoritesRepository repository}) : _repo = repository;

  final favorites = <Article>[].obs;
  final selectedChannel = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _refresh();
  }

  void _refresh() {
    favorites.value = _repo.filterByChannel(selectedChannel.value.isEmpty ? null : selectedChannel.value);
  }

  Future<void> toggleFavorite(Article article) async {
    await _repo.toggleFavorite(article);
    _refresh();
  }

  bool isFavorite(Article article) => _repo.isFavorite(article);

  void setChannelFilter(String channel) {
    selectedChannel.value = channel;
    _refresh();
  }
}
