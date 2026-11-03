import 'package:flutter/foundation.dart';
import 'package:mynewsapp/core/utils/logger.dart';


/// Interface for crash reporting. Real impl wraps Crashlytics (see README).
abstract class CrashReporter {
  Future<void> recordError(Object error, StackTrace stack, {bool fatal});
  void recordFlutterError(FlutterErrorDetails details);
  void log(String message);
  void setCustomKey(String key, Object value);
}

/// Default impl: prints to the console so the project runs with no Firebase.
class ConsoleCrashReporter implements CrashReporter {
  @override
  Future<void> recordError(Object error, StackTrace stack,
      {bool fatal = false,}) async {
    AppLogger.error(error, stack, fatal ? 'CRASH(fatal)' : 'CRASH(non-fatal)');
  }

  @override
  void recordFlutterError(FlutterErrorDetails details) {
    AppLogger.error(details.exception, details.stack ?? StackTrace.current,
        'FLUTTER_ERROR',);
  }

  @override
  void log(String message) => AppLogger.log(message, 'CRASH_LOG');

  @override
  void setCustomKey(String key, Object value) =>
      AppLogger.log('$key = $value', 'CRASH_KEY');
}
