import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  static const _storage = FlutterSecureStorage();
  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _userIdKey = 'user_id';
  static const _themeKey = 'theme_mode';

  static Future<void> init() async {}

  static Future<void> setAccessToken(String token) async =>
      await _storage.write(key: _accessTokenKey, value: token);

  static Future<String?> getAccessToken() async =>
      await _storage.read(key: _accessTokenKey);

  static Future<void> setRefreshToken(String token) async =>
      await _storage.write(key: _refreshTokenKey, value: token);

  static Future<String?> getRefreshToken() async =>
      await _storage.read(key: _refreshTokenKey);

  static Future<void> setUserId(String id) async =>
      await _storage.write(key: _userIdKey, value: id);

  static Future<String?> getUserId() async =>
      await _storage.read(key: _userIdKey);

  static Future<void> clearAll() async =>
      await _storage.deleteAll();
}
