import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

/// Thin logging wrapper. Never use `print` or `dart:developer`'s `log`
/// directly elsewhere in the app — always go through AppLogger, so the
/// backend can change in one place.
class AppLogger {
  AppLogger._();

  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 8,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    // Debug/info are compiled out of the evaluation entirely in release
    // builds — only warnings and above are ever processed there.
    level: kDebugMode ? Level.trace : Level.warning,
  );

  static void log(String message, [String? context]) {
    _logger.d(context != null ? '[$context] $message' : message);
  }

  static void info(String message, [String? context]) {
    _logger.i(context != null ? '[$context] $message' : message);
  }

  static void warning(String message, [String? context]) {
    _logger.w(context != null ? '[$context] $message' : message);
  }

  static void error(Object error, StackTrace stack, [String? context]) {
    _logger.e(
      context ?? 'Error',
      error: error,
      stackTrace: stack,
    );
  }

  static void fatal(Object error, StackTrace stack, [String? context]) {
    _logger.f(
      context ?? 'Fatal',
      error: error,
      stackTrace: stack,
    );
  }
}
