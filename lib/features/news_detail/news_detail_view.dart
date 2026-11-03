import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/features/news_detail/news_detail_controller.dart';

const _fallbackImage =
    "https://static.vecteezy.com/system/resources/previews/022/059/000/non_2x/no-image-available-icon-vector.jpg";

/// Unifies views/newsDiscription_new.dart and views/CatagroicesNewsDiscrip.dart —
/// both rendered the same layout for what is now one domain Article model.
class NewsDetailView extends GetView<NewsDetailController> {
  const NewsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final article = controller.article;
    return SafeArea(
      top: true,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text("News Details", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Get.back(),
          ),
          actions: [
            Obx(() => IconButton(
                  icon: Icon(
                    controller.isFavoriteRx.value ? Icons.bookmark : Icons.bookmark_outline,
                    color: controller.isFavoriteRx.value ? Colors.red : null,
                  ),
                  onPressed: controller.toggleFavorite,
                )),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  article.urlToImage ?? _fallbackImage,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 100),
                ),
              ),
              const SizedBox(height: 16),
              Text(article.title ?? "No title available",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(article.description ?? "No description available",
                  style: const TextStyle(fontSize: 16), textAlign: TextAlign.justify),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  label: const Text("To Learn More, Click Here"),
                  icon: const Icon(Icons.link),
                  onPressed: controller.openUrl,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
