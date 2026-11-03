import 'package:get/get.dart';
import 'package:mynewsapp/core/analytics/analytics_service.dart';
import 'package:mynewsapp/core/auth/auth_service.dart';
import 'package:mynewsapp/core/network/api_client.dart';
import 'package:mynewsapp/core/observability/app_error_handler.dart';
import 'package:mynewsapp/core/observability/crash_reporter.dart';
import 'package:mynewsapp/core/storage/local_storage_service.dart';
import 'package:mynewsapp/data/repositories/auth_repository_impl.dart';
import 'package:mynewsapp/data/repositories/favorites_repository_impl.dart';
import 'package:mynewsapp/data/repositories/news_repository_impl.dart';
import 'package:mynewsapp/data/services/news_api_service.dart';
import 'package:mynewsapp/domain/repositories/auth_repository.dart';
import 'package:mynewsapp/domain/repositories/favorites_repository.dart';
import 'package:mynewsapp/domain/repositories/news_repository.dart';

/// App-lifetime singletons: observability, services, repositories.
/// Registered once, before runApp — see main.dart.
class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Observability — registered first: everything below depends on
    // AppErrorHandler being findable via Get.find<AppErrorHandler>().
    final crash = ConsoleCrashReporter();
    final analytics = LoggingAnalyticsService();
    Get.put<CrashReporter>(crash, permanent: true);
    Get.put<AnalyticsService>(analytics, permanent: true);
    Get.put<AppErrorHandler>(AppErrorHandler(crash, analytics), permanent: true);

    // Core services
    Get.put<ApiClient>(
      ApiClient(errorHandler: Get.find<AppErrorHandler>()),
      permanent: true,
    );
    Get.put<LocalStorageService>(
      LocalStorageService(errorHandler: Get.find<AppErrorHandler>()),
      permanent: true,
    );
    Get.put<NewsApiService>(NewsApiService(Get.find()), permanent: true);

    // Repositories (interface -> impl)
    Get.put<NewsRepository>(
      NewsRepositoryImpl(
        api: Get.find<NewsApiService>(),
        errorHandler: Get.find<AppErrorHandler>(),
      ),
      permanent: true,
    );
    Get.put<FavoritesRepository>(
      FavoritesRepositoryImpl(storage: Get.find<LocalStorageService>()),
      permanent: true,
    );
    Get.put<AuthRepository>(
      AuthRepositoryImpl(errorHandler: Get.find<AppErrorHandler>()),
      permanent: true,
    );

    // Universal auth status stream
    Get.put<AuthService>(AuthService(Get.find<AuthRepository>()), permanent: true);
  }

  /// Async setup that must complete before the first protected route opens
  /// (e.g. restoring persisted favorites).
  Future<void> dependenciesAsync() async {
    dependencies();
    await Get.find<FavoritesRepository>().loadFavorites();
  }
}
