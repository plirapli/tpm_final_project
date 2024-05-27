import 'package:shared_preferences/shared_preferences.dart';

class SessionManager {
  static const String _credential = 'credential';
  static Future<void> setCredential(String data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(_credential, data);
  }

  static Future<String?> getCredential() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_credential);
  }

  static Future<void> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
