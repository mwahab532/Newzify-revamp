import 'package:get/get.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';
import 'package:mynewsapp/features/auth/register/register_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterController>(
      () => RegisterController(repository: Get.find<AuthRepository>()),
    );
  }
}
