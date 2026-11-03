import 'package:get/get.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';
import 'package:mynewsapp/features/auth/login/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(repository: Get.find<AuthRepository>()),
    );
  }
}
