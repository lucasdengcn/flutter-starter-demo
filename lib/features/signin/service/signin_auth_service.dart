import 'package:flutter/foundation.dart';

class SigninAuthService {
  // Singleton instance
  static final SigninAuthService _instance = SigninAuthService._internal();
  factory SigninAuthService() => _instance;
  SigninAuthService._internal();

  // Mock authentication - in production, this would integrate with a real authentication service
  Future<bool> authenticateUser(String phoneNumber, String password) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // For testing, any non-empty password is considered valid
      bool isValid = password.isNotEmpty;

      if (kDebugMode) {
        print(
          'Authentication ${isValid ? 'successful' : 'failed'} for $phoneNumber',
        );
      }
      return isValid;
    } catch (e) {
      if (kDebugMode) {
        print('Error authenticating user: $e');
      }
      return false;
    }
  }

  // Check if phone number exists (mock implementation)
  Future<bool> checkPhoneNumberExists(String phoneNumber) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // For testing, assume all phone numbers exist
      if (kDebugMode) {
        print('Phone number $phoneNumber exists');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error checking phone number: $e');
      }
      return false;
    }
  }
}
