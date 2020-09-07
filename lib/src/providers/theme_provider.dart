import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:news_summarizer/src/utils/shared_prefs.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData theme;

  ThemeProvider() {
    this.theme = darkTheme;
    getUserTheme();
  }

  getUserTheme() async {
    var _isDarkMode = await SharedPrefs.getIsDarkMode();
    if (_isDarkMode != null) {
      if (_isDarkMode) {
        theme = darkTheme;
      } else {
        theme = lightTheme;
      }
    } else {
      theme = darkTheme;
    }
    notifyListeners();
  }

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    accentColor: Color(0xff69F0AE),
    primaryColor: Color(0xff1d1f3e),
    primaryColorDark: Color(0xff1d1f3e),
    backgroundColor: Color(0xff1d1f3e),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
    ),
    cardColor: Color(0xff262845),
    fontFamily: "Circular-Std",
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
            transitionType: SharedAxisTransitionType.scaled,
            fillColor: Color(0xff1d1f3e)),
      },
    ),
  );

  final lightTheme = ThemeData(
    brightness: Brightness.light,
    accentColor: Color(0xff69F0AE),
    primaryColor: Color(0xff009688),
    primaryColorDark: Color(0xff009688),
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
            fillColor: Colors.white),
      },
    ),
  );

  void setDarkTheme() {
    theme = darkTheme;
    SharedPrefs.setIsDarkMode(true);
    notifyListeners();
  }

  void setLightTheme() {
    theme = lightTheme;
    SharedPrefs.setIsDarkMode(false);
    notifyListeners();
  }

  void toggleTheme() {
    theme = theme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
