import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';

import '../../../core/service/api_client.dart';
import '../../../core/service/token_storage.dart';
import '../model/auth_response_model.dart';

class SigninAuthService {
  // Singleton instance
  static final SigninAuthService _instance = SigninAuthService._internal();
  factory SigninAuthService() => _instance;
  SigninAuthService._internal();

  // Get singleton instances from service locator
  final ApiClient _apiClient = GetIt.instance<ApiClient>();
  final TokenStorage _tokenStorage = GetIt.instance<TokenStorage>();

  // Authenticate user with API
  Future<bool> authenticateUser(String phoneNumber, String password) async {
    try {
      final response = await _apiClient.post('auth/signin', {
        'phoneNumber': phoneNumber,
        'password': password,
      });

      final authResponse = AuthResponseModel.fromJson(response);

      if (authResponse.success && authResponse.token != null) {
        // Store the token for future authenticated requests
        if (authResponse.refreshToken != null) {
          _tokenStorage.setTokens(
            authResponse.token!,
            authResponse.refreshToken!,
          );
        } else {
          _tokenStorage.setToken(authResponse.token!);
        }

        if (kDebugMode) {
          print('Authentication successful for $phoneNumber');
        }
        return true;
      } else {
        if (kDebugMode) {
          print('Authentication failed: ${authResponse.message}');
        }
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error authenticating user: $e');
      }
      return false;
    }
  }

  // Check if phone number exists with API
  Future<bool> checkPhoneNumberExists(String phoneNumber) async {
    try {
      final response = await _apiClient.post('auth/check-phone', {
        'phoneNumber': phoneNumber,
      });

      final authResponse = AuthResponseModel.fromJson(response);

      if (kDebugMode) {
        print('Phone number check result: ${authResponse.success}');
      }

      return authResponse.success;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking phone number: $e');
      }
      return false;
    }
  }
}
