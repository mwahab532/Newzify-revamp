import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:mynewsapp/app/routes/app_routes.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';

class ProfileController extends GetxController {
  final AuthRepository _repo;

  ProfileController({
    required AuthRepository repository,
  }) : _repo = repository;

  final username = ''.obs;

  AppUser? get user => _repo.currentUser;

  String get formattedDate {
    if (user?.createdAt == null) return "Unknown";
    return DateFormat("dd MMMM yyyy").format(user!.createdAt!);
  }

  @override
  void onInit() {
    super.onInit();
    _loadUsername();
  }

  Future<void> _loadUsername() async {
    username.value = await _repo.fetchUsername();
  }

  void openFavorites() {
    Get.toNamed(AppRoutes.favorites);
  }

  Future<void> deleteAccount() async {
    await _repo.deleteAccount();
    Get.offAllNamed(AppRoutes.login);
  }

  Future<void> logout() async {
    await _repo.signOut();
  }
}
