import 'dart:convert';
import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import 'logger_service.dart';
import 'token_storage.dart';

class ApiClient {
  // Singleton instance
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  // Get singleton instances from service locator
  final TokenStorage _tokenStorage = GetIt.instance<TokenStorage>();
  final LoggerService _logger = GetIt.instance<LoggerService>();

  // Base URL for API calls
  final String baseUrl =
      'https://api.example.com'; // Replace with your actual API URL

  // Headers for API calls
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  // Add auth token to headers if available
  Future<Map<String, String>> _getAuthHeaders(String? token) async {
    final headers = Map<String, String>.from(_headers);

    // If token is provided, use it directly
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
      return headers;
    }

    // Otherwise, check if we have a stored token
    final storedToken = _tokenStorage.token;
    if (storedToken != null) {
      // Check if token is valid or needs refresh
      final jwtToken = _tokenStorage.jwtToken;
      if (jwtToken == null || jwtToken.shouldRefresh) {
        // Token is expired or about to expire, try to refresh it
        final refreshed = await _refreshToken();
        if (!refreshed) {
          // If refresh failed and token is expired, return headers without token
          if (jwtToken == null || jwtToken.isExpired) {
            return headers;
          }
          // If token is about to expire but not yet expired, we can still use it
        }
      }

      // Add the valid token to headers
      headers['Authorization'] = 'Bearer ${_tokenStorage.token}';
    }

    return headers;
  }

  // Refresh the token using refresh token
  Future<bool> _refreshToken() async {
    final refreshToken = _tokenStorage.refreshToken;
    if (refreshToken == null) {
      _logger.w('No refresh token available');
      return false;
    }

    try {
      _logger.d('Attempting to refresh token');

      final response = await http.post(
        Uri.parse('$baseUrl/auth/refresh'),
        headers: _headers,
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final newToken = data['token'] as String?;
        final newRefreshToken = data['refreshToken'] as String?;

        if (newToken != null) {
          if (newRefreshToken != null) {
            _tokenStorage.setTokens(newToken, newRefreshToken);
            _logger.i('Token and refresh token updated successfully');
          } else {
            _tokenStorage.setToken(newToken);
            _logger.i(
              'Token updated successfully, using existing refresh token',
            );
          }
          return true;
        } else {
          _logger.w('Refresh response did not contain a new token');
        }
      } else {
        _logger.e(
          'Token refresh failed with status code: ${response.statusCode}',
        );
        try {
          final errorData = jsonDecode(response.body) as Map<String, dynamic>;
          _logger.e('Error message: ${errorData['message']}');
        } catch (_) {}
      }

      // If we reach here, refresh failed
      return false;
    } catch (e) {
      _logger.e('Error refreshing token', e);
      return false;
    }
  }

  // GET request
  Future<Map<String, dynamic>> get(String endpoint, {String? token}) async {
    try {
      final headers = await _getAuthHeaders(token);
      final response = await http.get(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // POST request
  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> data, {
    String? token,
  }) async {
    try {
      final headers = await _getAuthHeaders(token);
      final response = await http.post(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // PUT request
  Future<Map<String, dynamic>> put(
    String endpoint,
    Map<String, dynamic> data, {
    String? token,
  }) async {
    try {
      final headers = await _getAuthHeaders(token);
      final response = await http.put(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
        body: jsonEncode(data),
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // DELETE request
  Future<Map<String, dynamic>> delete(String endpoint, {String? token}) async {
    try {
      final headers = await _getAuthHeaders(token);
      final response = await http.delete(
        Uri.parse('$baseUrl/$endpoint'),
        headers: headers,
      );
      return _handleResponse(response);
    } catch (e) {
      return _handleError(e);
    }
  }

  // Handle API response
  Map<String, dynamic> _handleResponse(http.Response response) {
    _logger.d('Response status: ${response.statusCode}');
    _logger.d('Response body: ${response.body}');

    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isEmpty) {
        return {'success': true};
      }
      try {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } catch (e) {
        return {'success': false, 'message': 'Failed to parse response'};
      }
    } else if (response.statusCode == 401) {
      // Unauthorized - token might be invalid
      _tokenStorage.clearToken();
      return {
        'success': false,
        'message': 'Authentication failed. Please log in again.',
        'auth_error': true,
      };
    } else {
      try {
        final errorData = jsonDecode(response.body) as Map<String, dynamic>;
        return {
          'success': false,
          'message':
              errorData['message'] ??
              'Request failed with status: ${response.statusCode}',
          'data': errorData,
        };
      } catch (e) {
        return {
          'success': false,
          'message': 'Request failed with status: ${response.statusCode}',
        };
      }
    }
  }

  // Handle errors
  Map<String, dynamic> _handleError(dynamic error) {
    _logger.e('API request error', error);

    String message = 'An unexpected error occurred';

    if (error is SocketException) {
      message = 'No internet connection';
    } else if (error is FormatException) {
      message = 'Invalid response format';
    } else if (error is HttpException) {
      message = 'HTTP error occurred';
    } else if (error is http.ClientException) {
      message = 'Request timeout';
    }

    return {'success': false, 'message': message};
  }
}
