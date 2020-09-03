import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData theme;

  ThemeProvider() {
    this.theme = darkTheme;
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
    brightness: Brightness.dark,
    accentColor: Color(0xff3B916E),
    primaryColor: Colors.white,
    primaryColorDark: Colors.white,
    backgroundColor: Colors.white,
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff3B916E)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xff3B916E)),
      ),
      labelStyle: TextStyle(color: Colors.grey),
      hintStyle: TextStyle(color: Colors.grey),
      focusColor: Color(0xff3B916E),
      helperStyle: TextStyle(color: Colors.grey),
      fillColor: Color(0xff3B916E),
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
    notifyListeners();
  }

  void setLightTheme() {
    theme = lightTheme;
    notifyListeners();
  }

  void toggleTheme() {
    theme = theme == lightTheme ? darkTheme : lightTheme;
    notifyListeners();
  }
}
