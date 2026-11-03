import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mynewsapp/shared/models/article.dart';

const _fallbackImage =
    "https://static.vecteezy.com/system/resources/previews/022/059/000/non_2x/no-image-available-icon-vector.jpg";

/// Was two near-identical widgets — widgets/customnews.dart (news feed,
/// with favorite/share actions) and widgets/catafgorices.dart (categories
/// feed, no actions). Unified per the "rule of two": callbacks are
/// optional, so the same dumb card serves both screens.
class NewsCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;
  final bool? isFavorite;
  final VoidCallback? onFavoriteToggle;
  final VoidCallback? onShare;

  const NewsCard({
    super.key,
    required this.article,
    required this.onTap,
    this.isFavorite,
    this.onFavoriteToggle,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.tryParse(article.publishedAt ?? '');
    final formattedDate = dateTime != null ? DateFormat("dd, MMMM yyyy").format(dateTime) : '';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: CachedNetworkImage(
              imageUrl: (article.urlToImage?.isNotEmpty ?? false) ? article.urlToImage! : _fallbackImage,
              height: 200.0,
              width: double.infinity,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.image_not_supported)),
            ),
          ),
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Container(
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                child: Text(
                  article.sourceName ?? "Unknown Source",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            const Spacer(),
            if (onShare != null)
              IconButton(
                icon: const Icon(Icons.share, color: Colors.red),
                onPressed: onShare,
              ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(formattedDate, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(
                article.title ?? "No Title Available",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12.0),
      ],
    );
  }
}
