import 'package:flutter/foundation.dart';

import '../model/jwt_token_model.dart';

/// A token storage service for managing JWT authentication tokens.
/// In a production app, this would use secure storage like flutter_secure_storage.
class TokenStorage {
  // Singleton instance
  static final TokenStorage _instance = TokenStorage._internal();
  factory TokenStorage() => _instance;
  TokenStorage._internal();

  String? _authToken;
  JwtTokenModel? _jwtTokenModel;
  String? _refreshToken;

  // Get the current auth token
  String? get token => _authToken;

  // Get the refresh token if available
  String? get refreshToken => _refreshToken;

  // Get the decoded JWT token model
  JwtTokenModel? get jwtToken => _jwtTokenModel;

  // Set the auth token
  void setToken(String token) {
    _authToken = token;
    try {
      _jwtTokenModel = JwtTokenModel(token);
      if (kDebugMode) {
        print('JWT Token stored successfully');
        print('Token expires at: ${_jwtTokenModel?.expirationDate}');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error decoding JWT token: $e');
      }
      _jwtTokenModel = null;
    }
  }

  // Set both auth token and refresh token
  void setTokens(String token, String refreshToken) {
    setToken(token);
    _refreshToken = refreshToken;
    if (kDebugMode) {
      print('Refresh token stored successfully');
    }
  }

  // Clear the auth token
  void clearToken() {
    _authToken = null;
    _jwtTokenModel = null;
    _refreshToken = null;
    if (kDebugMode) {
      print('Tokens cleared');
    }
  }

  // Check if user is authenticated
  bool get isAuthenticated => _authToken != null;

  // Check if token is valid and not expired
  bool get isTokenValid {
    if (_authToken == null || _jwtTokenModel == null) return false;
    try {
      return !_jwtTokenModel!.isExpired;
    } catch (e) {
      if (kDebugMode) {
        print('Error validating token: $e');
      }
      return false;
    }
  }

  // Check if token should be refreshed (expired or about to expire)
  bool get shouldRefreshToken {
    if (_authToken == null || _jwtTokenModel == null) return false;
    try {
      return _jwtTokenModel!.shouldRefresh;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking if token should be refreshed: $e');
      }
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
