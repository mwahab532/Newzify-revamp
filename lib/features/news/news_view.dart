import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';
import 'package:mynewsapp/core/theme/app_text_styles.dart';
import 'package:mynewsapp/features/news/news_controller.dart';
import 'package:mynewsapp/features/news/widgets/channel_filter_menu.dart';
import 'package:mynewsapp/shared/widgets/cards/news_card.dart';
import 'package:mynewsapp/shared/widgets/state/error_view.dart';
import 'package:mynewsapp/shared/widgets/state/shimmer_news_list.dart';
import 'package:share_plus/share_plus.dart';

/// Was views/News.dart.
class NewsView extends GetView<NewsController> {
  const NewsView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.transparent,
          title: Text("Top News headlines", style: AppTextStyles.title),
          actions: const [ChannelFilterMenu()],
        ),
        body: Obx(() => switch (controller.state) {
              NewsLoading() => const ShimmerNewsList(),
              NewsFailure(:final message) => ErrorView(message: message, onRetry: controller.load),
              NewsEmpty() => const Center(child: Text('No news data available')),
              NewsSuccess(:final articles) => RefreshIndicator(
                  onRefresh: controller.load,
                  child: ListView.builder(
                    itemCount: articles.length,
                    itemBuilder: (context, index) {
                      final article = articles[index];
                      return NewsCard(
                        article: article,
                        onTap: () => Get.toNamed(AppRoutes.newsDetail, arguments: article),
                        isFavorite: controller.isFavorite(article),
                        onFavoriteToggle: () => controller.toggleFavorite(article),
                        onShare: () => Share.share(article.url ?? "No URL Available"),
                      );
                    },
                  ),
                ),
            }),
      ),
    );
  }
}
