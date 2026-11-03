import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_otp_auth/email_otp_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mynewsapp/core/observability/app_error_handler.dart';
import 'package:mynewsapp/core/error/app_exception.dart';
import 'package:mynewsapp/core/network/result.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';

/// Merges what used to be Auth/Auth_services .dart, Auth/Registerservices.dart,
/// Auth/googleSigin/googlesigin.dart, and the OTP calls scattered across
/// Register/otpverification views — one domain area (user account), one
/// repository, per §02 rule 4 (single source of truth).
class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;
  final GoogleSignIn _googleSignIn;
  final AppErrorHandler _errorHandler;

  AuthRepositoryImpl({
    required AppErrorHandler errorHandler,
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
    GoogleSignIn? googleSignIn,
  })  : _errorHandler = errorHandler,
        _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn();

  CollectionReference<Map<String, dynamic>> get _usersCollection =>
      _firestore.collection('users');

  @override
  Stream<bool> get authStateChanges =>
      _firebaseAuth.authStateChanges().map((user) => user != null);

  @override
  AppUser? get currentUser {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;
    return AppUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      createdAt: user.metadata.creationTime,
    );
  }

  @override
  Future<Result<void>> signInWithEmailPassword(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return const Ok(null);
    } on FirebaseAuthException catch (e) {
      // Expected user-facing failure (wrong password, etc.) — not a bug,
      // so it's surfaced via Result, not reported to Crashlytics.
      return Err(AppException.auth(_messageForAuthError(e), code: e.code));
    } catch (e, st) {
      _errorHandler.report(e, st, context: 'AuthRepository.signInWithEmailPassword');
      return Err(AppException.unknown(e.toString()));
    }
  }

  @override
  Future<Result<void>> registerWithEmailPassword({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final uid = credential.user?.uid;
      if (uid != null) {
        await _usersCollection.doc(uid).set({'username': username});
      }
      return const Ok(null);
    } on FirebaseAuthException catch (e) {
      return Err(AppException.auth(_messageForAuthError(e), code: e.code));
    } catch (e, st) {
      _errorHandler.report(e, st, context: 'AuthRepository.registerWithEmailPassword');
      return Err(AppException.unknown(e.toString()));
    }
  }

  @override
  Future<Result<void>> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return Err(AppException.auth('Sign-in cancelled.'));
      }
      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
      return const Ok(null);
    } catch (e, st) {
      _errorHandler.report(e, st, context: 'AuthRepository.signInWithGoogle');
      return Err(AppException.auth('Sign-in error occurred: ${e.toString()}'));
    }
  }

  @override
  Future<Result<void>> sendOtp(String email) async {
    try {
      final res = await EmailOtpAuth.sendOTP(email: email);
      if (res['message'] == 'Email Send') {
        return const Ok(null);
      }
      return Err(AppException.auth('Invalid e-mail address.'));
    } catch (e, st) {
      _errorHandler.report(e, st, context: 'AuthRepository.sendOtp');
      return Err(AppException.unknown(e.toString()));
    }
  }

  @override
  Future<Result<bool>> verifyOtp(String otp) async {
    try {
      final res = await EmailOtpAuth.verifyOtp(otp: otp);
      if (res['message'] == 'OTP Verified') {
        return const Ok(true);
      }
      if (res['data'] == 'OTP Expired') {
        return Err(AppException.auth('OTP expired.'));
      }
      return const Ok(false);
    } catch (e, st) {
      _errorHandler.report(e, st, context: 'AuthRepository.verifyOtp');
      return Err(AppException.unknown(e.toString()));
    }
  }

  @override
  Future<String> fetchUsername() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return 'Unknown User';
    if (user.displayName != null && user.displayName!.isNotEmpty) {
      return user.displayName!;
    }
    try {
      final doc = await _usersCollection.doc(user.uid).get();
      if (doc.exists && doc.data()?['username'] != null) {
        return doc.data()!['username'] as String;
      }
      return 'Unknown User';
    } catch (e, st) {
      _errorHandler.report(e, st, context: 'AuthRepository.fetchUsername');
      return 'Unknown User';
    }
  }

  @override
  Future<void> deleteAccount() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        await _usersCollection.doc(user.uid).delete();
        await user.delete();
      } catch (e, st) {
        _errorHandler.report(e, st, context: 'AuthRepository.deleteAccount');
        rethrow;
      }
    }
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }

  String _messageForAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      default:
        return 'Failed to sign in: ${e.message}';
    }
  }
}
