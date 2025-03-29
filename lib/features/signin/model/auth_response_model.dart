import 'package:json_annotation/json_annotation.dart';

part 'auth_response_model.g.dart';

@JsonSerializable()
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

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthResponseModelToJson(this);

  factory AuthResponseModel.error(String message) {
    return AuthResponseModel(success: false, message: message);
  }
}
