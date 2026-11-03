/// A typed, user-friendly exception. Nothing raw (DioException, FormatException,
/// FirebaseAuthException, ...) should cross out of the data layer as-is.
class AppException implements Exception {
  final String userMessage;
  final String? code;
  final Object? cause;

  const AppException(this.userMessage, {this.code, this.cause});

  factory AppException.network() => const AppException(
        "Oops! Check your connection and try again.",
        code: 'network_error',
      );

  factory AppException.server([String? detail]) => AppException(
        detail ?? "Something went wrong! No data is available right now.",
        code: 'server_error',
      );

  factory AppException.unknown(String detail) =>
      AppException("Something went wrong.", code: 'unknown', cause: detail);

  factory AppException.auth(String message, {String? code}) =>
      AppException(message, code: code ?? 'auth_error');

  @override
  String toString() => 'AppException($code): $userMessage';
}
