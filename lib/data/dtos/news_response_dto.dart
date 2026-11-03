import 'package:mynewsapp/data/dtos/article_dto.dart';

/// Mirrors NewsAPI's response envelope. Was `newschannelsApisModels`
/// (top-headlines) and `CategoriesModel` (everything) — both had the
/// identical {status, totalResults, articles[]} shape, so one DTO now
/// serves both endpoints.
class NewsResponseDto {
  final String? status;
  final int? totalResults;
  final List<ArticleDto> articles;

  const NewsResponseDto({this.status, this.totalResults, this.articles = const []});

  factory NewsResponseDto.fromJson(Map<String, dynamic> json) {
    final rawArticles = json['articles'] as List<dynamic>?;
    return NewsResponseDto(
      status: json['status'] as String?,
      totalResults: json['totalResults'] as int?,
      articles: rawArticles
              ?.map((v) => ArticleDto.fromJson(v as Map<String, dynamic>))
              .toList() ??
          const [],
    );
  }
}
