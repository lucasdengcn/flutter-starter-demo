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

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
      otpCode: json['otpCode'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'otpCode': otpCode,
      'isVerified': isVerified,
    };
  }

  UserModel copyWith({
    String? name,
    String? phoneNumber,
    String? otpCode,
    bool? isVerified,
  }) {
    return UserModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otpCode: otpCode ?? this.otpCode,
      isVerified: isVerified ?? this.isVerified,
    );
  }
}
