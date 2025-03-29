import 'package:get_it/get_it.dart';

import '../model/jwt_token_model.dart';
import '../service/logger_service.dart';
import '../service/secure_storage_service.dart';

/// A token storage service for managing JWT authentication tokens.
/// In a production app, this would use secure storage like flutter_secure_storage.
class TokenStorage {
  // Singleton instance
  static final TokenStorage _instance = TokenStorage._internal();
  factory TokenStorage() => _instance;
  TokenStorage._internal();

  // Get service instances from service locator
  final LoggerService _logger = GetIt.instance<LoggerService>();
  final SecureStorageService _secureStorage =
      GetIt.instance<SecureStorageService>();

  String? _authToken;
  JwtTokenModel? _jwtTokenModel;
  String? _refreshToken;

  // Initialize tokens from secure storage
  Future<void> init() async {
    try {
      final storedAuthToken = await _secureStorage.getAuthToken();
      final storedRefreshToken = await _secureStorage.getRefreshToken();

      if (storedAuthToken != null) {
        setToken(storedAuthToken);
      }
      if (storedRefreshToken != null) {
        _refreshToken = storedRefreshToken;
      }
    } catch (e) {
      _logger.e('Error initializing tokens from secure storage', e);
    }
  }

  // Get the current auth token
  String? get token => _authToken;

  // Get the refresh token if available
  String? get refreshToken => _refreshToken;

  // Get the decoded JWT token model
  JwtTokenModel? get jwtToken => _jwtTokenModel;

  // Set the auth token
  Future<void> setToken(String token) async {
    _authToken = token;
    try {
      _jwtTokenModel = JwtTokenModel(token);
      await _secureStorage.storeAuthToken(token);
      _logger.i('JWT Token stored successfully');
      _logger.i('Token expires at: ${_jwtTokenModel?.expirationDate}');
    } catch (e) {
      _logger.e('Error storing JWT token', e);
      _jwtTokenModel = null;
    }
  }

  // Set both auth token and refresh token
  Future<void> setTokens(String token, String refreshToken) async {
    await setToken(token);
    try {
      await _secureStorage.storeRefreshToken(refreshToken);
      _refreshToken = refreshToken;
      _logger.d('Refresh token stored successfully');
    } catch (e) {
      _logger.e('Error storing refresh token', e);
    }
  }

  // Clear all tokens
  Future<void> clearTokens() async {
    await _secureStorage.clearAll();
    _jwtTokenModel = null;
    _logger.d('All tokens cleared');
  }

  // Check if user is authenticated
  bool get isAuthenticated => _authToken != null;

  // Check if token is valid and not expired
  bool get isTokenValid {
    if (_authToken == null || _jwtTokenModel == null) return false;
    try {
      return !_jwtTokenModel!.isExpired;
    } catch (e) {
      _logger.e('Error validating token', e);
      return false;
    }
  }

  // Check if token should be refreshed (expired or about to expire)
  bool get shouldRefreshToken {
    if (_authToken == null || _jwtTokenModel == null) return false;
    try {
      return _jwtTokenModel!.shouldRefresh;
    } catch (e) {
      _logger.e('Error checking if token should be refreshed', e);
      return true; // If there's an error, better to try refreshing
    }
  }

  // Get remaining time until token expiration
  Duration? get tokenRemainingTime {
    if (_jwtTokenModel == null) return null;
    return _jwtTokenModel!.remainingTime;
  }

  // Get user ID from token if available
  String? get userId => _jwtTokenModel?.userId;
}
