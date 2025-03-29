import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';

import 'logger_service.dart';

/// A secure storage service for storing sensitive data using flutter_secure_storage.
/// This service encrypts data at rest using platform-specific encryption.
class SecureStorageService {
  static final SecureStorageService _instance =
      SecureStorageService._internal();
  factory SecureStorageService() => _instance;
  SecureStorageService._internal();

  final _storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  final LoggerService _logger = GetIt.instance<LoggerService>();

  // Storage keys
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userDataKey = 'user_data';

  /// Securely stores the authentication token
  Future<void> storeAuthToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      _logger.d('Auth token stored securely');
    } catch (e) {
      _logger.e('Error storing auth token', e);
      rethrow;
    }
  }

  /// Retrieves the stored authentication token
  Future<String?> getAuthToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      _logger.e('Error retrieving auth token', e);
      return null;
    }
  }

  /// Securely stores the refresh token
  Future<void> storeRefreshToken(String token) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: token);
      _logger.d('Refresh token stored securely');
    } catch (e) {
      _logger.e('Error storing refresh token', e);
      rethrow;
    }
  }

  /// Retrieves the stored refresh token
  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: _refreshTokenKey);
    } catch (e) {
      _logger.e('Error retrieving refresh token', e);
      return null;
    }
  }

  /// Securely stores user data as encrypted JSON
  Future<void> storeUserData(Map<String, dynamic> userData) async {
    try {
      final jsonStr = jsonEncode(userData);
      await _storage.write(key: _userDataKey, value: jsonStr);
      _logger.d('User data stored securely');
    } catch (e) {
      _logger.e('Error storing user data', e);
      rethrow;
    }
  }

  /// Retrieves and decodes stored user data
  Future<Map<String, dynamic>?> getUserData() async {
    try {
      final jsonStr = await _storage.read(key: _userDataKey);
      if (jsonStr == null) return null;
      return jsonDecode(jsonStr) as Map<String, dynamic>;
    } catch (e) {
      _logger.e('Error retrieving user data', e);
      return null;
    }
  }

  /// Deletes all stored secure data
  Future<void> clearAll() async {
    try {
      await _storage.deleteAll();
      _logger.i('All secure storage data cleared');
    } catch (e) {
      _logger.e('Error clearing secure storage', e);
      rethrow;
    }
  }

  /// Deletes specific stored data by key
  Future<void> delete(String key) async {
    try {
      await _storage.delete(key: key);
      _logger.d('Deleted secure storage key: $key');
    } catch (e) {
      _logger.e('Error deleting from secure storage', e);
      rethrow;
    }
  }
}
