import 'package:get/get.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';
import 'package:mynewsapp/features/auth/otp/otp_controller.dart';

class OtpBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpController>(
      () => OtpController(repository: Get.find<AuthRepository>()),
    );
  }
}
