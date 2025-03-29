import 'package:get_it/get_it.dart';

import '../../../core/service/api_client.dart';
import '../../../core/service/logger_service.dart';
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
  final LoggerService _logger = GetIt.instance<LoggerService>();

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

        _logger.d('Authentication successful for $phoneNumber');

        return true;
      } else {
        _logger.e('Authentication failed: ${authResponse.message}');
        return false;
      }
    } catch (e) {
      _logger.e('Error authenticating user', e);
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

      _logger.d('Phone number check result: ${authResponse.success}');

      return authResponse.success;
    } catch (e) {
      _logger.e('Error checking phone number', e);
      return false;
    }
  }
}
