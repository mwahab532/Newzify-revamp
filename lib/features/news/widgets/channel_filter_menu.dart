import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/core/constants/app_constants.dart';
import 'package:mynewsapp/features/news/news_controller.dart';

/// Was widgets/filterchannel_widget.dart. Screen-private to the news
/// feature (only used here), so it lives under features/news/widgets.
class ChannelFilterMenu extends StatelessWidget {
  const ChannelFilterMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewsController>();
    return PopupMenuButton<NewsChannel>(
      icon: const Icon(Icons.more_vert),
      onSelected: (channel) => controller.filterByChannel(channel.apiValue),
      itemBuilder: (context) => NewsChannel.values
          .map((c) => PopupMenuItem(value: c, child: Text(c.label)))
          .toList(),
    );
  }
}
