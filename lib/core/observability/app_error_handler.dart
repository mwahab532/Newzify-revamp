

import 'package:flutter/foundation.dart';
import 'package:mynewsapp/core/analytics/analytics_service.dart';
import 'package:mynewsapp/core/observability/crash_reporter.dart';
import 'package:mynewsapp/core/utils/logger.dart';


/// The single funnel every layer uses for errors (handbook §14).
class AppErrorHandler {
  AppErrorHandler(this._crash, this._analytics);

  final CrashReporter _crash;
  final AnalyticsService _analytics;

  /// Install the framework-level hooks. Call once in main().
  void install() {
    FlutterError.onError = (details) {
      FlutterError.presentError(details);
      _crash.recordFlutterError(details);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      report(error, stack, context: 'PlatformDispatcher', fatal: true);
      return true;
    };
  }

  /// The single funnel for handled (non-fatal) errors from any layer.
  Future<void> report(
    Object error,
    StackTrace stack, {
    String? context,
    bool fatal = false,
    Map<String, Object>? keys,
  }) async {
    AppLogger.error(error, stack, context);
    keys?.forEach(_crash.setCustomKey);
    if (context != null) _crash.log(context);
    await _crash.recordError(error, stack, fatal: fatal);
    await _analytics.logEvent('app_error', {
      'context': context ?? 'unknown',
      'type': error.runtimeType.toString(),
      'fatal': fatal,
    });
  }
}
