import 'package:get_it/get_it.dart';

import '../config/app_config.dart';
import 'logger_service.dart';

/// A service that provides configuration management throughout the application.
/// Follows the singleton pattern to ensure a single instance is used app-wide.
class ConfigService {
  // Singleton instance
  static final ConfigService _instance = ConfigService._internal();
  factory ConfigService() => _instance;

  ConfigService._internal() {
    _initConfig();
  }

  // Logger service for logging configuration events
  final LoggerService _logger = GetIt.instance<LoggerService>();

  // Current environment
  Environment _environment = Environment.development;
  Environment get environment => _environment;

  // API configuration
  late String _apiBaseUrl;
  String get apiBaseUrl => _apiBaseUrl;

  // Feature flags
  final Map<String, bool> _featureFlags = {};

  // App settings
  final Map<String, dynamic> _settings = {};

  /// Initialize configuration based on the current environment
  void _initConfig() {
    try {
      // Set environment based on AppConfig
      final envString = AppConfig.environment;
      _environment = Environment.values.firstWhere(
        (e) => e.name == envString,
        orElse: () => Environment.development,
      );

      _logger.i(
        'Initializing ConfigService for ${_environment.name} environment',
      );

      // Set API URL from AppConfig
      _apiBaseUrl = AppConfig.apiBaseUrl;
      _logger.d('API Base URL set to: $_apiBaseUrl');

      // Initialize default feature flags
      _featureFlags.addAll({
        'enableAnalytics': _environment == Environment.production,
        'enableCrashReporting': _environment != Environment.development,
        'showDebugInfo': _environment != Environment.production,
      });

      // Initialize default settings
      _settings.addAll({
        'cacheTimeoutMinutes': AppConfig.defaultCacheMaxAge,
        'maxRetryAttempts': 3,
        'timeoutSeconds': AppConfig.defaultConnectionTimeout,
      });

      _logger.i('ConfigService initialized successfully');
    } catch (e, stackTrace) {
      _logger.e('Failed to initialize ConfigService', e, stackTrace);
      // Set fallback values
      _apiBaseUrl = 'https://api.example.com';
    }
  }

  /// Get a feature flag value
  bool getFeatureFlag(String key, {bool defaultValue = false}) {
    return _featureFlags[key] ?? defaultValue;
  }

  /// Set a feature flag value
  void setFeatureFlag(String key, bool value) {
    _featureFlags[key] = value;
    _logger.d('Feature flag updated: $key = $value');
  }

  /// Get a setting value
  T? getSetting<T>(String key, {T? defaultValue}) {
    final value = _settings[key];
    if (value is T) {
      return value;
    }
    return defaultValue;
  }

  /// Set a setting value
  void setSetting<T>(String key, T value) {
    _settings[key] = value;
    _logger.d('Setting updated: $key = $value');
  }

  /// Override the API base URL (useful for testing)
  void setApiBaseUrl(String url) {
    _apiBaseUrl = url;
    _logger.i('API base URL overridden: $url');
  }

  /// Reset all configurations to default values
  void resetToDefaults() {
    _initConfig();
    _logger.i('ConfigService reset to defaults');
  }
}
