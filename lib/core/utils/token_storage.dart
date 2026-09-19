import 'package:shared_preferences/shared_preferences.dart';
import 'app_logger.dart';

/// Persists and retrieves the user's auth token using SharedPreferences.
class TokenStorage {
  TokenStorage._();

  static const String _tokenKey = 'auth_token';
  static const String _usernameKey = 'username';

  /// Save token and username after successful login/register
  static Future<void> saveToken(String token, {String? username}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
    if (username != null) {
      await prefs.setString(_usernameKey, username);
    }
    AppLogger.info('Token saved successfully', tag: 'TokenStorage');
  }

  /// Retrieve saved token; returns null if not found
  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    AppLogger.log(
      token != null ? 'Token retrieved' : 'No token found',
      tag: 'TokenStorage',
    );
    return token;
  }

  /// Retrieve saved username
  static Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  /// Check if a token exists (user is logged in)
  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear token on logout
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_usernameKey);
    AppLogger.info('Token cleared', tag: 'TokenStorage');
  }
}
