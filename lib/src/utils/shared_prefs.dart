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
}
