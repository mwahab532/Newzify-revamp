import 'package:mynewsapp/shared/models/article.dart';

abstract class FavoritesRepository {
  /// Loads persisted favorites once, at app/controller start.
  Future<List<Article>> loadFavorites();

  /// Current in-memory favorites (post-load).
  List<Article> get favorites;

  bool isFavorite(Article article);

  Future<void> toggleFavorite(Article article);

  List<Article> filterByChannel(String? channelName);
}
