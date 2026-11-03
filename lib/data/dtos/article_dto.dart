import 'package:mynewsapp/data/dtos/source_dto.dart';
import 'package:mynewsapp/shared/models/article.dart';

/// Mirrors the NewsAPI article JSON exactly. Never used by the UI directly —
/// [toDomain] maps it to the app-shaped [Article].
class ArticleDto {
  final SourceDto? source;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const ArticleDto({
    this.source,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory ArticleDto.fromJson(Map<String, dynamic> json) => ArticleDto(
        source: json['source'] != null
            ? SourceDto.fromJson(json['source'] as Map<String, dynamic>)
            : null,
        author: json['author'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        url: json['url'] as String?,
        urlToImage: json['urlToImage'] as String?,
        publishedAt: json['publishedAt'] as String?,
        content: json['content'] as String?,
      );

  Article toDomain() => Article(
        sourceId: source?.id,
        sourceName: source?.name,
        author: author,
        title: title,
        description: description,
        url: url,
        urlToImage: urlToImage,
        publishedAt: publishedAt,
        content: content,
      );
}
