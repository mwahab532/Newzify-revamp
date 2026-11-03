import 'package:get/get.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

/// Universal auth status, mirroring the manual's §13 AuthService shape —
/// backed here by Firebase's authStateChanges stream rather than an OIDC
/// token pair, since this project uses Firebase Auth, not Keycloak.
class AuthService extends GetxService {
  final AuthRepository _repo;
  AuthService(this._repo);

  final status = AuthStatus.unknown.obs;

  @override
  void onInit() {
    super.onInit();
    _repo.authStateChanges.listen((isAuthed) {
      status.value = isAuthed ? AuthStatus.authenticated : AuthStatus.unauthenticated;
    });
  }

  AppUser? get currentUser => _repo.currentUser;
}
