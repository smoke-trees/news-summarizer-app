import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData theme;

  ThemeProvider() {
    this.theme = darkTheme;
  }

  final darkTheme = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.deepPurpleAccent,
    primaryColor: Color(0xff1d1f3e),
    primaryColorDark: Color(0xff1d1f3e),
    backgroundColor: Color(0xff1d1f3e),
    cardColor: Color(0xff262845),
    fontFamily: "Circular-Std",
  );

  final lightTheme = ThemeData(
    brightness: Brightness.dark,
    accentColor: Colors.greenAccent,
    primaryColor: Color(0xff1d1f3e),
    primaryColorDark: Color(0xff1d1f3e),
    backgroundColor: Color(0xff1d1f3e),
    cardColor: Color(0xff343651),
    fontFamily: "Circular-Std",
  );

  void setDarkTheme() {
    theme = darkTheme;
    notifyListeners();
  }

  void setLightTheme() {
    theme = lightTheme;
    notifyListeners();
  }
}