import 'package:flutter/foundation.dart';

class SignupAuthService {
  // Singleton instance
  static final SignupAuthService _instance = SignupAuthService._internal();
  factory SignupAuthService() => _instance;
  SignupAuthService._internal();

  // Mock OTP verification - in production, this would integrate with a real SMS service
  Future<bool> sendOTP(String phoneNumber) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      if (kDebugMode) {
        print('OTP sent to $phoneNumber');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error sending OTP: $e');
      }
      return false;
    }
  }

  // Mock OTP verification
  Future<bool> verifyOTP(String phoneNumber, String otp) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      // For testing, any 6-digit OTP is considered valid
      bool isValid = otp.length == 6 && int.tryParse(otp) != null;
      if (kDebugMode) {
        print(
          'OTP verification ${isValid ? 'successful' : 'failed'} for $phoneNumber',
        );
      }
      return isValid;
    } catch (e) {
      if (kDebugMode) {
        print('Error verifying OTP: $e');
      }
      return false;
    }
  }

  // Create user profile
  Future<bool> createUserProfile(String phoneNumber, String name) async {
    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));
      if (kDebugMode) {
        print('User profile created for $name with phone $phoneNumber');
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print('Error creating user profile: $e');
      }
      return false;
    }
  }
}
