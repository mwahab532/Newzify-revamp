import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';
import 'package:mynewsapp/core/theme/app_text_styles.dart';
import 'package:mynewsapp/features/favorites/favorites_controller.dart';

const _fallbackImage =
    "https://static.vecteezy.com/system/resources/previews/022/059/000/non_2x/no-image-available-icon-vector.jpg";

class FavoritesView extends GetView<FavoritesController> {
  const FavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text("Saved News", style: AppTextStyles.favoriteAppBar),
      ),
      body: Obx(() {
        final items = controller.favorites.reversed.toList();

        if (items.isEmpty) {
          return Center(
            child: Text(
              "No favorite news saved yet",
              style: AppTextStyles.favoriteEmptyBody,
            ),
          );
        }

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final article = items[index];
            final dateTime = DateTime.tryParse(article.publishedAt ?? '');
            final format = DateFormat("dd, MMMM yyyy");

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Get.toNamed(AppRoutes.newsDetail, arguments: article),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: CachedNetworkImage(
                        imageUrl: article.urlToImage ?? _fallbackImage,
                        height: 200.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.high,
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6.0),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Text(
                          article.sourceName ?? '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () => controller.toggleFavorite(article),
                        icon: const Icon(Icons.bookmark, color: Colors.red),
                      ),
                    ],
                  ),
                  if (dateTime != null)
                    Text(format.format(dateTime), style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8.0),
                  Text(
                    article.title ?? '',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }
}