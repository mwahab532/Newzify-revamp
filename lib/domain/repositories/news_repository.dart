import 'package:mynewsapp/core/network/result.dart';
import 'package:mynewsapp/shared/models/article.dart';

abstract class NewsRepository {
  Future<Result<List<Article>>> getTopHeadlines(String channel);
  Future<Result<List<Article>>> getArticlesByCategory(String category);
}
