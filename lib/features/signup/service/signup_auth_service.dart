import 'package:get_it/get_it.dart';

import '../../../core/service/api_client.dart';
import '../../../core/service/logger_service.dart';
import '../../../core/service/token_storage.dart';
import '../../../features/signin/model/auth_response_model.dart';
import '../model/user_model.dart';

class SignupAuthService {
  // Singleton instance
  static final SignupAuthService _instance = SignupAuthService._internal();
  factory SignupAuthService() => _instance;
  SignupAuthService._internal();

  // Get singleton instances from service locator
  final ApiClient _apiClient = GetIt.instance<ApiClient>();
  final TokenStorage _tokenStorage = GetIt.instance<TokenStorage>();
  final LoggerService _logger = GetIt.instance<LoggerService>();

  // Send OTP via API
  Future<bool> sendOTP(String phoneNumber) async {
    try {
      final response = await _apiClient.post('auth/send-otp', {
        'phoneNumber': phoneNumber,
      });

      final authResponse = AuthResponseModel.fromJson(response);

      _logger.d('OTP request result: ${authResponse.success}');
      if (!authResponse.success) {
        _logger.e('Error message: ${authResponse.message}');
      }

      return authResponse.success;
    } catch (e) {
      _logger.e('Error sending OTP', e);
      return false;
    }
  }

  // Verify OTP via API
  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    try {
      final response = await _apiClient.post('auth/verify-otp', {
        'phoneNumber': phoneNumber,
        'otpCode': otp,
      });

      final authResponse = AuthResponseModel.fromJson(response);

      _logger.d('OTP verification result: ${authResponse.success}');
      if (!authResponse.success) {
        _logger.e('Error message: ${authResponse.message}');
      }

      return authResponse.success;
    } catch (e) {
      _logger.e('Error verifying OTP', e);
      return false;
    }
  }

  // Create user profile via API
  Future<bool> createUserProfile(String phoneNumber, String name) async {
    try {
      final userModel = UserModel(
        name: name,
        phoneNumber: phoneNumber,
        isVerified: true,
      );

      final response = await _apiClient.post('auth/signup', userModel.toJson());

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

        _logger.d('User profile created for $name with phone $phoneNumber');
        return true;
      } else {
        _logger.e('Failed to create user profile: ${authResponse.message}');
        return false;
      }
    } catch (e) {
      _logger.e('Error creating user profile', e);
      return false;
    }
  }
}
