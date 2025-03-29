import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Environment types
enum Environment { development, sit, uat, staging, production }

/// Configuration constants for different environments
class AppConfig {
  // Private constructor to prevent direct instantiation
  AppConfig._();

  /// Current environment
  static String get environment {
    // First try to get from .env file
    final envFromDotEnv = dotenv.env['ENVIRONMENT'];
    if (envFromDotEnv != null) {
      return envFromDotEnv;
    }
    return Environment.development.name;
  }

  /// API URL
  static String get apiBaseUrl =>
      dotenv.env['API_URL'] ?? 'https://api.example.com';

  /// Default timeout values (in seconds)
  static int get defaultConnectionTimeout =>
      int.tryParse(dotenv.env['CONNECTION_TIMEOUT'] ?? '') ?? 30;
  static int get defaultReceiveTimeout =>
      int.tryParse(dotenv.env['RECEIVE_TIMEOUT'] ?? '') ?? 30;

  /// Cache configuration
  static int get defaultCacheMaxAge =>
      int.tryParse(dotenv.env['CACHE_MAX_AGE_DAYS'] ?? '') ?? 7; // days
  static int get defaultCacheMaxSize =>
      int.tryParse(dotenv.env['CACHE_MAX_SIZE_BYTES'] ?? '') ??
      10 * 1024 * 1024; // 10 MB

  /// Feature flags
  static final Map<String, bool> featureFlags = {
    'enableAnalytics': environment == Environment.production.name,
    'enableCrashReporting': environment != Environment.development.name,
    'showDebugInfo': environment != Environment.production.name,
  };

  /// App settings
  static final Map<String, dynamic> appSettings = {
    'cacheTimeoutMinutes': 30,
    'maxRetryAttempts': 3,
    'timeoutSeconds': 30,
  };
}
