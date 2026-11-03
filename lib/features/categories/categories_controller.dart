import 'package:get/get.dart';
import 'package:mynewsapp/core/constants/app_constants.dart';
import 'package:mynewsapp/core/network/result.dart';
import 'package:mynewsapp/domain/repositories/news_repository.dart';
import 'package:mynewsapp/shared/models/article.dart';

sealed class CategoriesViewState {
  const CategoriesViewState();
}

class CategoriesLoading extends CategoriesViewState {
  const CategoriesLoading();
}

class CategoriesSuccess extends CategoriesViewState {
  final List<Article> articles;
  const CategoriesSuccess(this.articles);
}

class CategoriesFailure extends CategoriesViewState {
  final String message;
  const CategoriesFailure(this.message);
}

class CategoriesEmpty extends CategoriesViewState {
  const CategoriesEmpty();
}

class CategoriesController extends GetxController {
  final NewsRepository _repo;
  CategoriesController({required NewsRepository repository}) : _repo = repository;

  final _state = Rx<CategoriesViewState>(const CategoriesLoading());
  CategoriesViewState get state => _state.value;

  final selectedCategory = AppConstants.defaultCategory.obs;

  @override
  void onInit() {
    super.onInit();
    load();
  }

  Future<void> load() async {
    _state.value = const CategoriesLoading();
    final result = await _repo.getArticlesByCategory(selectedCategory.value);
    _state.value = switch (result) {
      Ok(value: final articles) when articles.isEmpty => const CategoriesEmpty(),
      Ok(value: final articles) => CategoriesSuccess(articles),
      Err(:final error) => CategoriesFailure(error.userMessage),
    };
  }

  Future<void> selectCategory(String category) async {
    selectedCategory.value = category;
    await load();
  }
}
