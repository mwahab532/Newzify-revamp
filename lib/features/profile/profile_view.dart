import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mynewsapp/core/theme/app_text_styles.dart';
import 'package:mynewsapp/features/profile/profile_controller.dart';

/// Was views/profile.dart.
class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Text('Profile', style: AppTextStyles.profileTitle),
      ),
      body: Column(
        spacing: 10,
        children: [
          Center(
            child: CircleAvatar(
                radius: 60,
                backgroundImage:controller. user?.photoUrl != null
                    ? NetworkImage(controller.user!.photoUrl!)
                    : null,
                child:controller. user?.photoUrl == null
                    ? const Icon(Icons.person, size: 30, color: Colors.white)
                    : null),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.person),
                      title: const Text('Name'),
                      subtitle: Obx(() => Text(
                          controller.username.value.isNotEmpty
                              ? controller.username.value
                              : "Fetching...")),
                    ),
                    ListTile(
                      leading: const Icon(Icons.verified_user_outlined),
                      title: const Text('User ID'),
                      subtitle: Text(controller.user?.uid ?? ''),
                    ),
                    ListTile(
                      leading: const Icon(Icons.calendar_month),
                      title: const Text('Created At'),
                      subtitle: Text(controller.formattedDate),
                    ),
                    ListTile(
                      leading: const Icon(Icons.bookmark),
                      title: const Text('Save News'),
                      onTap: controller.openFavorites,
                    ),
                    ListTile(
                      leading: const Icon(Icons.delete, color: Colors.red),
                      title: const Text('Delete',
                          style: TextStyle(color: Colors.red)),
                      onTap: controller.deleteAccount,
                    ),
                    ListTile(
                      leading: const Icon(Icons.logout, color: Colors.red),
                      title: const Text('Logout',
                          style: TextStyle(color: Colors.red)),
                      onTap: controller.logout,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
