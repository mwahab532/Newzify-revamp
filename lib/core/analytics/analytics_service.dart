import 'package:mynewsapp/core/utils/logger.dart';

/// Only file in the app allowed to import `firebase_analytics`.
/// Feature code should never call FirebaseAnalytics directly.

abstract class AnalyticsService {
  Future<void> logEvent(String name, [Map<String, Object>? params]);
  Future<void> setUserId(String? id);
  Future<void> logScreen(String name);
}

class LoggingAnalyticsService implements AnalyticsService {
  
  @override
  Future<void> logEvent(String name, [Map<String, Object>? params]) async{
   AppLogger.log('event: $name ${params ?? ''}', 'ANALYTICS');
  }
  
  @override
  Future<void> logScreen(String name)async {
 AppLogger.log('screen: $name', 'ANALYTICS');
  }
  
  @override
  Future<void> setUserId(String? id)async {
    AppLogger.log('userId = $id', 'ANALYTICS');
  }
}
