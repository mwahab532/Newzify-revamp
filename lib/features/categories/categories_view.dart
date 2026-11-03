import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';
import 'package:mynewsapp/core/constants/app_constants.dart';
import 'package:mynewsapp/core/theme/app_text_styles.dart';
import 'package:mynewsapp/features/categories/categories_controller.dart';
import 'package:mynewsapp/features/categories/widgets/category_chip.dart';
import 'package:mynewsapp/shared/widgets/cards/news_card.dart';
import 'package:mynewsapp/shared/widgets/state/error_view.dart';
import 'package:mynewsapp/shared/widgets/state/shimmer_news_list.dart';

/// Was views/Newscartagorices.dart.
class CategoriesView extends GetView<CategoriesController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.black,
          title: Text("News Categories", style: AppTextStyles.searchAppBar),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 50,
              child: Obx(() {
                final selected = controller
                    .selectedCategory.value; 
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: AppConstants.categoryList.length,
                  itemBuilder: (context, index) {
                    final category = AppConstants.categoryList[index];
                    return CategoryChip(
                      label: category,
                      isSelected:
                          selected == category, // use the captured value
                      onTap: () => controller.selectCategory(category),
                    );
                  },
                );
              }),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Obx(() => switch (controller.state) {
                    CategoriesLoading() => const ShimmerNewsList(),
                    CategoriesFailure(:final message) =>
                      ErrorView(message: message, onRetry: controller.load),
                    CategoriesEmpty() => const Center(
                        child: Text('No news data available',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    CategoriesSuccess(:final articles) => ListView.builder(
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
                          return NewsCard(
                            article: article,
                            onTap: () => Get.toNamed(AppRoutes.newsDetail,
                                arguments: article),
                          );
                        },
                      ),
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
