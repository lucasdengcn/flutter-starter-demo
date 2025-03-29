import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String name;
  final String phoneNumber;
  final String? otpCode;
  final bool isVerified;

  UserModel({
    required this.name,
    required this.phoneNumber,
    this.otpCode,
    this.isVerified = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
