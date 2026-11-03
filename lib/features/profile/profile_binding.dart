import 'package:get/get.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';
import 'package:mynewsapp/features/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(repository: Get.find<AuthRepository>()),
    );
  }
}
