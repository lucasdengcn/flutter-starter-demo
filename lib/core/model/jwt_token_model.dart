import 'package:jwt_decoder/jwt_decoder.dart';

/// Model class representing a JWT token with its decoded data
class JwtTokenModel {
  final String token;
  final Map<String, dynamic> decodedData;
  final DateTime expirationDate;
  final Duration bufferTime;

  /// Creates a JwtTokenModel by decoding the provided JWT token
  /// [bufferTime] is used to consider a token as expired before its actual expiration
  /// to prevent using tokens that are about to expire
  JwtTokenModel(this.token, {this.bufferTime = const Duration(minutes: 5)})
    : decodedData = JwtDecoder.decode(token),
      expirationDate = JwtDecoder.getExpirationDate(token);

  /// Checks if the token is expired
  bool get isExpired => JwtDecoder.isExpired(token);

  /// Checks if the token is about to expire within the buffer time
  bool get isAboutToExpire {
    final now = DateTime.now();
    return now.add(bufferTime).isAfter(expirationDate);
  }

  /// Checks if the token should be refreshed (either expired or about to expire)
  bool get shouldRefresh => isExpired || isAboutToExpire;

  /// Returns the remaining time until the token expires
  Duration get remainingTime => expirationDate.difference(DateTime.now());

  /// Returns the user ID from the token payload if available
  String? get userId => decodedData['sub'] as String?;

  /// Returns any custom claims from the token
  dynamic getClaimValue(String claimKey) {
    return decodedData[claimKey];
  }

  @override
  String toString() {
    return 'JwtTokenModel{token: $token, expirationDate: $expirationDate, isExpired: $isExpired}';
  }
}
