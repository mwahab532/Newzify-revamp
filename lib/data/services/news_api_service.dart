import 'package:mynewsapp/core/constants/app_constants.dart';
import 'package:mynewsapp/core/network/api_client.dart';
import 'package:mynewsapp/data/dtos/news_response_dto.dart';

/// Knows transport, knows nothing about business rules. Was
/// services/Newsapi.dart (raw `http` calls) — ported onto the shared Dio
/// client from core/network.
class NewsApiService {
  final ApiClient _client;
  NewsApiService(this._client);

  Future<NewsResponseDto> fetchTopHeadlines(String channel) async {
    final response = await _client.dio.get(
      '/top-headlines',
      queryParameters: {'sources': channel, 'apiKey': AppConstants.apiKey},
    );
    return NewsResponseDto.fromJson(response.data as Map<String, dynamic>);
  }

  Future<NewsResponseDto> fetchByCategory(String category) async {
    final response = await _client.dio.get(
      '/everything',
      queryParameters: {'q': category, 'apiKey': AppConstants.apiKey},
    );
    return NewsResponseDto.fromJson(response.data as Map<String, dynamic>);
  }
}
