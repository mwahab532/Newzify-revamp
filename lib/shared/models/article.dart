/// The single domain model for a news article. Was two near-identical
/// classes (`Articles` in models/NewschannelsApis.dart and `Article` in
/// models/catagoricesModel.dart) — both mirrored the same NewsAPI shape,
/// so they're unified here per the "rule of two" / no-duplication rule.
///
/// This is pure Dart: no GetX, no Flutter, no Dio.
class Article {
  final String? sourceId;
  final String? sourceName;
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  const Article({
    this.sourceId,
    this.sourceName,
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  /// Stable identity for favoriting/list-diffing — articles have no numeric
  /// id from the API, so the URL is the closest thing to one.
  String get id => url ?? title ?? '$sourceName-$publishedAt';

  Article copyWith({
    String? sourceId,
    String? sourceName,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) =>
      Article(
        sourceId: sourceId ?? this.sourceId,
        sourceName: sourceName ?? this.sourceName,
        author: author ?? this.author,
        title: title ?? this.title,
        description: description ?? this.description,
        url: url ?? this.url,
        urlToImage: urlToImage ?? this.urlToImage,
        publishedAt: publishedAt ?? this.publishedAt,
        content: content ?? this.content,
      );

  Map<String, dynamic> toStorageJson() => {
        'sourceId': sourceId,
        'sourceName': sourceName,
        'author': author,
        'title': title,
        'description': description,
        'url': url,
        'urlToImage': urlToImage,
        'publishedAt': publishedAt,
        'content': content,
      };

  factory Article.fromStorageJson(Map<String, dynamic> json) => Article(
        sourceId: json['sourceId'] as String?,
        sourceName: json['sourceName'] as String?,
        author: json['author'] as String?,
        title: json['title'] as String?,
        description: json['description'] as String?,
        url: json['url'] as String?,
        urlToImage: json['urlToImage'] as String?,
        publishedAt: json['publishedAt'] as String?,
        content: json['content'] as String?,
      );

  @override
  bool operator ==(Object other) => other is Article && other.id == id;

  @override
  int get hashCode => id.hashCode;
}
