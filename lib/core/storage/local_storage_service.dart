// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:mynewsapp/core/observability/app_error_handler.dart';

// /// Light key-value persistence, per the manual's "local persistence is
// /// light" assumption. Was the ad-hoc SharedPreferences calls inside
// /// Provider/faviroteprovider.dart. A heavier need can swap this for
// /// get_storage without touching any other layer.
// class LocalStorageService {
//   static const _favoritesKey = 'favoriteNews';

//   final AppErrorHandler _errorHandler;
//   LocalStorageService({required AppErrorHandler errorHandler}) : _errorHandler = errorHandler;

//   Future<void> saveJsonList(String key, List<Map<String, dynamic>> items) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(key, jsonEncode(items));
//   }

//   Future<List<Map<String, dynamic>>> readJsonList(String key) async {
//     final prefs = await SharedPreferences.getInstance();
//     final raw = prefs.getString(key);
//     if (raw == null) return [];
//     try {
//       final decoded = jsonDecode(raw) as List<dynamic>;
//       return decoded.cast<Map<String, dynamic>>();
//     } catch (e, st) {
//       // Corrupt local data isn't the user's fault and isn't actionable by
//       // them — report it and fail soft to an empty list.
//       _errorHandler.report(e, st, context: 'LocalStorageService.readJsonList');
//       return [];
//     }
//   }

//   Future<void> saveFavorites(List<Map<String, dynamic>> items) =>
//       saveJsonList(_favoritesKey, items);

//   Future<List<Map<String, dynamic>>> readFavorites() =>
//       readJsonList(_favoritesKey);
// }
import 'dart:convert';
import 'package:mynewsapp/core/observability/app_error_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Light key-value persistence. Confines all direct SharedPreferences
/// access to this one file — repositories never touch SharedPreferences
/// directly.
class LocalStorageService {
  static const _favoritesKey = 'favoriteNews';

   // ignore: unused_field
   final AppErrorHandler _errorHandler;
   LocalStorageService({required AppErrorHandler errorHandler}) : _errorHandler = errorHandler;

  /// Persists the given list of favorite articles (as JSON maps) to
  /// SharedPreferences, replacing whatever was stored before.
  Future<void> saveFavorites(List<Map<String, dynamic>> items) async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(items);
    await prefs.setString(_favoritesKey, encoded);
  }

  /// Reads the persisted favorite articles back as a list of JSON maps.
  /// Returns an empty list if nothing has been saved yet, or if the
  /// stored data is corrupt/unreadable.
  Future<List<Map<String, dynamic>>> readFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_favoritesKey);
    if (raw == null) return [];

    try {
      final decoded = jsonDecode(raw) as List<dynamic>;
      return decoded.cast<Map<String, dynamic>>();
    } catch (_) {
      // Corrupt data shouldn't crash the app — fail soft to empty.
      return [];
    }
  }

  /// Convenience for wiping favorites entirely (e.g. on logout/reset).
  Future<void> clearFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_favoritesKey);
  }
}