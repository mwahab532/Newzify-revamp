import 'package:dio/dio.dart';
import 'package:mynewsapp/core/observability/app_error_handler.dart';
import 'package:mynewsapp/core/error/app_exception.dart';
import 'package:mynewsapp/core/network/result.dart';
import 'package:mynewsapp/data/services/news_api_service.dart';
import 'package:mynewsapp/domain/repositories/news_repository.dart';
import 'package:mynewsapp/shared/models/article.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsApiService _api;
  final AppErrorHandler _errorHandler;
  NewsRepositoryImpl({required NewsApiService api, required AppErrorHandler errorHandler})
      : _api = api,
        _errorHandler = errorHandler;

  @override
  Future<Result<List<Article>>> getTopHeadlines(String channel) async {
    try {
      final dto = await _api.fetchTopHeadlines(channel);
      return Ok(dto.articles.map((a) => a.toDomain()).toList());
    } on DioException catch (e, st) {
      _errorHandler.report(e, st, context: 'NewsRepository.getTopHeadlines');
      return Err(AppException.network());
    } catch (e, st) {
      _errorHandler.report(e, st, context: 'NewsRepository.getTopHeadlines');
      return Err(AppException.unknown(e.toString()));
    }
  }

  @override
  Future<Result<List<Article>>> getArticlesByCategory(String category) async {
    try {
      final dto = await _api.fetchByCategory(category);
      return Ok(dto.articles.map((a) => a.toDomain()).toList());
    } on DioException catch (e, st) {
      _errorHandler.report(e, st, context: 'NewsRepository.getArticlesByCategory');
      return Err(AppException.network());
    } catch (e, st) {
      _errorHandler.report(e, st, context: 'NewsRepository.getArticlesByCategory');
      return Err(AppException.unknown(e.toString()));
    }
  }
}
