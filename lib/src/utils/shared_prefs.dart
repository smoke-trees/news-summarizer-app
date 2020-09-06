import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  static Future<bool> getIsUserLoggedIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'isUserLoggedIn';
    return prefs.getBool(key);
  }

  static void setIsUserLoggedIn(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'isUserLoggedIn';
    prefs.setBool(key, value);
  }

  static Future<bool> getHasUserSelectedPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'hasUserSelectedPrefs';
    return prefs.getBool(key);
  }

  static void setHasUserSelectedPrefs(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final key = 'hasUserSelectedPrefs';
    prefs.setBool(key, value);
  }
}
