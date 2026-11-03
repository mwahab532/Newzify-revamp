import 'package:mynewsapp/core/network/result.dart';

class AppUser {
  final String uid;
  final String? email;
  final String? displayName;
  final String? photoUrl;
  final DateTime? createdAt;

  const AppUser({
    required this.uid,
    this.email,
    this.displayName,
    this.photoUrl,
    this.createdAt,
  });
}

/// Single source of truth for the user/auth domain area. Backed by
/// Firebase Auth + Firestore (see §13 note: this app predates the
/// Keycloak/OIDC convention — same shape, different backend).
abstract class AuthRepository {
  Stream<bool> get authStateChanges;

  AppUser? get currentUser;

  Future<Result<void>> signInWithEmailPassword(String email, String password);

  Future<Result<void>> registerWithEmailPassword({
    required String username,
    required String email,
    required String password,
  });

  Future<Result<void>> signInWithGoogle();

  Future<Result<void>> sendOtp(String email);

  Future<Result<bool>> verifyOtp(String otp);

  Future<String> fetchUsername();

  Future<void> deleteAccount();

  Future<void> signOut();
}
