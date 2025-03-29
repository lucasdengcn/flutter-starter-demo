import 'dart:convert';

import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CacheService {
  static final CacheService _instance = CacheService._internal();
  final Logger _logger = Logger();
  late SharedPreferences _prefs;

  // Singleton pattern
  factory CacheService() {
    return _instance;
  }

  CacheService._internal();

  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch (e) {
      _logger.e('Failed to initialize CacheService: $e');
      rethrow;
    }
  }

  Future<bool> setString(
    String key,
    String value, {
    Duration? expiration,
  }) async {
    try {
      final expirationTime =
          expiration != null
              ? DateTime.now().add(expiration).millisecondsSinceEpoch
              : null;

      final cacheData = {'value': value, 'expiration': expirationTime};

      return await _prefs.setString(key, jsonEncode(cacheData));
    } catch (e) {
      _logger.e('Error setting string in cache: $e');
      return false;
    }
  }

  Future<String?> getString(String key) async {
    try {
      final data = _prefs.getString(key);
      if (data == null) return null;

      final cacheData = jsonDecode(data) as Map<String, dynamic>;
      final expirationTime = cacheData['expiration'] as int?;

      if (expirationTime != null &&
          DateTime.now().millisecondsSinceEpoch > expirationTime) {
        await remove(key);
        return null;
      }

      return cacheData['value'] as String;
    } catch (e) {
      _logger.e('Error getting string from cache: $e');
      return null;
    }
  }

  Future<bool> setObject<T>(String key, T value, {Duration? expiration}) async {
    try {
      final jsonString = jsonEncode(value);
      return await setString(key, jsonString, expiration: expiration);
    } catch (e) {
      _logger.e('Error setting object in cache: $e');
      return false;
    }
  }

  Future<T?> getObject<T>(
    String key,
    T Function(Map<String, dynamic>) fromJson,
  ) async {
    try {
      final jsonString = await getString(key);
      if (jsonString == null) return null;

      final jsonMap = jsonDecode(jsonString) as Map<String, dynamic>;
      return fromJson(jsonMap);
    } catch (e) {
      _logger.e('Error getting object from cache: $e');
      return null;
    }
  }

  Future<bool> remove(String key) async {
    try {
      return await _prefs.remove(key);
    } catch (e) {
      _logger.e('Error removing key from cache: $e');
      return false;
    }
  }

  Future<bool> clear() async {
    try {
      return await _prefs.clear();
    } catch (e) {
      _logger.e('Error clearing cache: $e');
      return false;
    }
  }

  Future<bool> containsKey(String key) async {
    return _prefs.containsKey(key);
  }
}
