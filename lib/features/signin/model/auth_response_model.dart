class AuthResponseModel {
  final bool success;
  final String? token;
  final String? refreshToken;
  final String? message;
  final Map<String, dynamic>? data;

  AuthResponseModel({
    required this.success,
    this.token,
    this.refreshToken,
    this.message,
    this.data,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      success: json['success'] as bool? ?? false,
      token: json['token'] as String?,
      refreshToken: json['refreshToken'] as String?,
      message: json['message'] as String?,
      data: json['data'] as Map<String, dynamic>?,
    );
  }

  factory AuthResponseModel.error(String message) {
    return AuthResponseModel(success: false, message: message);
  }
}
