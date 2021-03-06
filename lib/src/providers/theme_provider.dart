import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:news_summarizer/src/utils/hive_prefs.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData theme;
  bool isDarkMode;
  ProfileHive sp = new ProfileHive();

  ThemeProvider() {
    this.theme = darkTheme;
    getUserTheme();
  }

  getUserTheme() async {
    var _isDarkMode = sp.getIsDarkMode();
    if (_isDarkMode != null) {
      if (_isDarkMode) {
        theme = darkTheme;
        isDarkMode = true;
      } else {
        theme = lightTheme;
        isDarkMode = false;
      }
    } else {
      theme = darkTheme;
      isDarkMode = true;
    }
    notifyListeners();
  }

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    accentColor: Color(0xff69F0AE),
    primaryColor: Color(0xff1d1f3e),
    primaryColorDark: Color(0xff1d1f3e),
    backgroundColor: Color(0xff1d1f3e),
    scaffoldBackgroundColor: Color(0xff1d1f3e),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    cardColor: Color(0xff262845),
    fontFamily: "Circular-Std",
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
          fillColor: Color(0xff1d1f3e),
        ),
      },
    ),
  );

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    accentColor: Color(0xff69F0AE),
    primaryColor: Color(0xff009688),
    primaryColorDark: Color(0xff055c54),
    backgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    cardColor: Color(0xfffafafa),
    fontFamily: "Circular-Std",
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
          fillColor: Colors.white,
        ),
      },
    ),
  );

  void setDarkTheme() {
    theme = darkTheme;
    sp.setIsDarkMode(true);
    isDarkMode = true;
    notifyListeners();
  }

  void setLightTheme() {
    theme = lightTheme;
    sp.setIsDarkMode(false);
    isDarkMode = false;
    notifyListeners();
  }

  void toggleTheme() {
    theme = theme == lightTheme ? darkTheme : lightTheme;
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
