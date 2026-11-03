import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:mynewsapp/core/constants/app_constants.dart';
import 'package:mynewsapp/core/observability/app_error_handler.dart';
import 'package:mynewsapp/core/utils/logger.dart';

/// A single Dio client configured once. Was the raw `http` calls in
/// services/Newsapi.dart — every data source now goes through this.
class ApiClient {
  late final Dio dio;

  ApiClient({required AppErrorHandler errorHandler}) {
    dio = Dio(BaseOptions(
      baseUrl: AppConstants.baseUrl,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ));

    // Full request/response logging — debug builds only. LogInterceptor
    // prints query params, which include the API key, so this must never
    // ship in release builds.
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
          logPrint: (obj) => AppLogger.log(obj.toString()),
        ),
      );
    }

    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          // Transport errors are expected (offline, timeouts) and are
          // already surfaced to the user via Result/AppException further
          // up — still funnel them through AppErrorHandler so they show
          // up in Crashlytics/analytics for trend-spotting, non-fatal.
          errorHandler.report(error, error.stackTrace, context: 'ApiClient');
          handler.next(error);
        },
      ),
    );
  }
}