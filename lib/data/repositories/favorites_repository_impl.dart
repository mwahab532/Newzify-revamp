import 'package:mynewsapp/core/storage/local_storage_service.dart';
import 'package:mynewsapp/domain/repositories/favorites_repository.dart';
import 'package:mynewsapp/shared/models/article.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  final LocalStorageService _storage;
  final Set<Article> _favorites = {};

  FavoritesRepositoryImpl({required LocalStorageService storage}) : _storage = storage;

  @override
  Future<List<Article>> loadFavorites() async {
    final stored = await _storage.readFavorites();
    _favorites
      ..clear()
      ..addAll(stored.map(Article.fromStorageJson));
    return favorites;
  }

  @override
  List<Article> get favorites => _favorites.toList();

  @override
  bool isFavorite(Article article) => _favorites.contains(article);

  @override
  Future<void> toggleFavorite(Article article) async {
    if (_favorites.contains(article)) {
      _favorites.remove(article);
    } else {
      _favorites.add(article);
    }
    await _storage.saveFavorites(_favorites.map((a) => a.toStorageJson()).toList());
  }

  @override
  List<Article> filterByChannel(String? channelName) {
    if (channelName == null || channelName.isEmpty) return favorites;
    return _favorites.where((a) => a.sourceName == channelName).toList();
  }
}
