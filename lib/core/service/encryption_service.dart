import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:get_it/get_it.dart';
import 'package:pointycastle/export.dart';

import '../config/security_config.dart';
import 'logger_service.dart';

/// Exception thrown when encryption operations fail
class EncryptionException implements Exception {
  final String message;
  final dynamic originalError;

  EncryptionException(this.message, [this.originalError]);

  @override
  String toString() => 'EncryptionException: $message';
}

/// Service for handling data encryption and decryption using industry-standard algorithms.
class EncryptionService {
  static final EncryptionService _instance = EncryptionService._internal();
  factory EncryptionService() => _instance;
  EncryptionService._internal();

  final SecurityConfig _securityConfig = GetIt.instance<SecurityConfig>();
  final LoggerService _logger = GetIt.instance<LoggerService>();
  final Random _random = Random.secure();

  /// Generates a cryptographically secure random key
  List<int> generateKey() {
    return List<int>.generate(
      _securityConfig.keyLength,
      (i) => _random.nextInt(256),
    );
  }

  /// Generates a cryptographically secure random IV (Initialization Vector)
  List<int> generateIV() {
    return List<int>.generate(
      _securityConfig.ivLength,
      (i) => _random.nextInt(256),
    );
  }

  /// Generates a random salt for key derivation
  List<int> generateSalt() {
    return List<int>.generate(
      _securityConfig.saltLength,
      (i) => _random.nextInt(256),
    );
  }

  /// Derives an encryption key from a password using PBKDF2
  List<int> deriveKey(String password, List<int> salt) {
    final codec = utf8.encoder;
    final passwordBytes = codec.convert(password);
    final params = Pbkdf2Parameters(
      Uint8List.fromList(salt),
      _securityConfig.iterations,
      _securityConfig.keyLength,
    );

    final pbkdf2 = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))..init(params);

    return pbkdf2.process(passwordBytes);
  }

  /// Validates input parameters for encryption
  void _validateEncryptionInput(String data, String? password) {
    if (data.isEmpty) {
      throw EncryptionException('Data to encrypt cannot be empty');
    }
    if (password != null && password.isEmpty) {
      throw EncryptionException('Password cannot be empty when provided');
    }
  }

  /// Encrypts data using AES-GCM
  Future<Map<String, String>> encrypt(String data, {String? password}) async {
    try {
      _validateEncryptionInput(data, password);

      final iv = generateIV();
      final salt = generateSalt();
      final key = password != null ? deriveKey(password, salt) : generateKey();

      // Prepare cipher parameters with proper GCM configuration
      final cipher = GCMBlockCipher(AESEngine())..init(
        true,
        AEADParameters(
          KeyParameter(Uint8List.fromList(key)),
          _securityConfig.tagLength * 8,
          Uint8List.fromList(iv),
          Uint8List(0), // Associated data (empty for this use case)
        ),
      );

      // Encrypt data with proper byte handling
      final plaintext = Uint8List.fromList(utf8.encode(data));
      final ciphertext = cipher.process(plaintext);

      // Encode results for storage/transmission
      final result = {
        'ciphertext': base64.encode(ciphertext),
        'iv': base64.encode(iv),
        'salt': base64.encode(salt),
      };

      _logger.d('Data encrypted successfully');
      return result;
    } catch (e) {
      final message =
          e is EncryptionException ? e.message : 'Encryption failed';
      _logger.e(message, e);
      throw EncryptionException(message, e);
    }
  }

  /// Validates input parameters for decryption
  void _validateDecryptionInput(
    Map<String, String> encryptedData,
    String? password,
  ) {
    if (!encryptedData.containsKey('ciphertext') ||
        !encryptedData.containsKey('iv') ||
        !encryptedData.containsKey('salt')) {
      throw EncryptionException('Invalid encrypted data format');
    }
    if (password != null && password.isEmpty) {
      throw EncryptionException('Password cannot be empty when provided');
    }
  }

  /// Decrypts data using AES-GCM
  Future<String> decrypt(
    Map<String, String> encryptedData, {
    String? password,
  }) async {
    try {
      _validateDecryptionInput(encryptedData, password);

      final ciphertext = base64.decode(encryptedData['ciphertext']!);
      final iv = base64.decode(encryptedData['iv']!);
      final salt = base64.decode(encryptedData['salt']!);
      final key = password != null ? deriveKey(password, salt) : generateKey();

      // Prepare cipher parameters with proper GCM configuration
      final cipher = GCMBlockCipher(AESEngine())..init(
        false,
        AEADParameters(
          KeyParameter(Uint8List.fromList(key)),
          _securityConfig.tagLength * 8,
          Uint8List.fromList(iv),
          Uint8List(0), // Associated data (empty for this use case)
        ),
      );

      // Decrypt data with proper byte handling
      final decrypted = cipher.process(Uint8List.fromList(ciphertext));
      final result = utf8.decode(decrypted);

      _logger.d('Data decrypted successfully');
      return result;
    } catch (e) {
      final message =
          e is EncryptionException ? e.message : 'Decryption failed';
      _logger.e(message, e);
      throw EncryptionException(message, e);
    }
  }

  /// Hashes data using SHA-256
  String hashData(String data) {
    final bytes = utf8.encode(data);
    final digest = SHA256Digest().process(Uint8List.fromList(bytes));
    return digest.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }

  /// Generates a secure random string of specified length
  String generateSecureRandomString(int length) {
    const charset =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    return List.generate(
      length,
      (_) => charset[_random.nextInt(charset.length)],
    ).join();
  }
}
