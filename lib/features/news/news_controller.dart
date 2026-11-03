import 'package:get/get.dart';
import 'package:mynewsapp/core/constants/app_constants.dart';
import 'package:mynewsapp/core/network/result.dart';
import 'package:mynewsapp/domain/repositories/favorites_repository.dart';
import 'package:mynewsapp/domain/repositories/news_repository.dart';
import 'package:mynewsapp/shared/models/article.dart';

sealed class NewsViewState {
  const NewsViewState();
}

class NewsLoading extends NewsViewState {
  const NewsLoading();
}

class NewsSuccess extends NewsViewState {
  final List<Article> articles;
  const NewsSuccess(this.articles);
}

class NewsFailure extends NewsViewState {
  final String message;
  const NewsFailure(this.message);
}

class NewsEmpty extends NewsViewState {
  const NewsEmpty();
}

class NewsController extends GetxController {
  final NewsRepository _newsRepo;
  final FavoritesRepository _favoritesRepo;
  NewsController({required NewsRepository newsRepository, required FavoritesRepository favoritesRepository})
      : _newsRepo = newsRepository,
        _favoritesRepo = favoritesRepository;

  final _state = Rx<NewsViewState>(const NewsLoading());
  NewsViewState get state => _state.value;

  String channelName = AppConstants.defaultChannel;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    _state.value = const NewsLoading();
    final result = await _newsRepo.getTopHeadlines(channelName);
    _state.value = switch (result) {
      Ok(value: final articles) when articles.isEmpty => const NewsEmpty(),
      Ok(value: final articles) => NewsSuccess(articles),
      Err(:final error) => NewsFailure(error.userMessage),
    };
  }

  Future<void> filterByChannel(String channel) async {
    channelName = channel;
    await load();
  }

  bool isFavorite(Article article) => _favoritesRepo.isFavorite(article);

  Future<void> toggleFavorite(Article article) async {
    await _favoritesRepo.toggleFavorite(article);
    _state.refresh();
  }
}
