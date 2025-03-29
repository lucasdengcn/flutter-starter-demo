import 'package:get_it/get_it.dart';

import '../service/logger_service.dart';

/// Security configuration service for managing API security settings and encryption.
class SecurityConfig {
  static final SecurityConfig _instance = SecurityConfig._internal();
  factory SecurityConfig() => _instance;
  SecurityConfig._internal();

  final LoggerService _logger = GetIt.instance<LoggerService>();

  // API Security Headers
  final Map<String, String> securityHeaders = {
    'X-Content-Type-Options': 'nosniff',
    'X-Frame-Options': 'DENY',
    'X-XSS-Protection': '1; mode=block',
    'Strict-Transport-Security': 'max-age=31536000; includeSubDomains',
    'Content-Security-Policy':
        "default-src 'self'; script-src 'self' 'unsafe-inline' 'unsafe-eval'; style-src 'self' 'unsafe-inline';",
    'Referrer-Policy': 'strict-origin-when-cross-origin',
  };

  // SSL/TLS Configuration
  final bool enforceHttps = true;
  final int minimumTlsVersion = 12; // TLS 1.2
  final List<String> supportedCipherSuites = [
    'TLS_AES_128_GCM_SHA256',
    'TLS_AES_256_GCM_SHA384',
    'TLS_CHACHA20_POLY1305_SHA256',
  ];

  // CORS Configuration
  final Map<String, String> corsHeaders = {
    'Access-Control-Allow-Origin': '*',
    'Access-Control-Allow-Methods': 'GET, POST, PUT, DELETE, OPTIONS',
    'Access-Control-Allow-Headers':
        'Origin, Content-Type, Accept, Authorization, X-Request-With',
    'Access-Control-Allow-Credentials': 'true',
  };

  // Rate Limiting Configuration
  final int maxRequestsPerMinute = 60;
  final int maxLoginAttemptsPerHour = 5;

  // Input Validation Rules
  final Map<String, String> inputValidationRules = {
    'password':
        r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$', // Min 8 chars, at least 1 letter and 1 number
    'email': r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    'phone': r'^\+?[1-9]\d{1,14}$', // International phone number format
  };

  // JWT Configuration
  final Duration jwtTokenExpiry = const Duration(hours: 1);
  final Duration refreshTokenExpiry = const Duration(days: 7);
  final int jwtRefreshThresholdMinutes =
      5; // Refresh token if less than 5 minutes remaining

  // Encryption Configuration
  final String aesMode = 'aes-256-gcm';
  final int ivLength = 12;
  final int tagLength = 16;
  final int saltLength = 16;
  final int iterations = 100000;
  final int keyLength = 32;

  /// Validates if a given input matches the defined validation rule
  bool validateInput(String input, String ruleKey) {
    final rule = inputValidationRules[ruleKey];
    if (rule == null) {
      _logger.w('No validation rule found for key: $ruleKey');
      return false;
    }
    return RegExp(rule).hasMatch(input);
  }

  /// Gets combined security headers including CORS
  Map<String, String> get allSecurityHeaders {
    return {...securityHeaders, ...corsHeaders};
  }

  /// Checks if the current environment requires HTTPS
  bool get requiresSecureConnection {
    // Add additional environment checks if needed
    return enforceHttps;
  }

  /// Gets the minimum required TLS version string
  String get tlsVersion => 'TLS 1.$minimumTlsVersion';

  /// Logs current security configuration
  void logSecurityConfig() {
    _logger.i('Security Configuration:');
    _logger.i('- HTTPS Enforced: $enforceHttps');
    _logger.i('- Minimum TLS Version: $tlsVersion');
    _logger.i('- Rate Limit: $maxRequestsPerMinute requests/minute');
    _logger.i('- JWT Token Expiry: ${jwtTokenExpiry.inHours} hours');
  }
}
