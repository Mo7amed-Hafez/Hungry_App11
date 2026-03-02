// ShardPreferences Helpers
import 'package:shared_preferences/shared_preferences.dart';

class PrefHelpers {
  static const String _tokenKey = 'auth_token';
  static Future<void> saveToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString(_tokenKey);
  }

  static Future<void> removeToken() async {
    final pref = await SharedPreferences.getInstance();
    pref.remove(_tokenKey);
  }
}


// ShardPreferences Helpers for user info and token storage in shared preferences and secure storage
// علشان نخزن معلومات اليوزر محليا في الهاتف
