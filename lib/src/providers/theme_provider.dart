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
    cardColor: Color(0xff262845),
    fontFamily: "Circular-Std",
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
          fillColor: Color(0xff1d1f3e)
        ),
      },
    ),
  );

  final lightTheme = ThemeData(
    brightness: Brightness.dark,
    accentColor: Color(0xff3B916E),
    primaryColor: Colors.white,
    primaryColorDark: Colors.white,
    backgroundColor: Colors.white,
    cardColor: Color(0xfffafafa),
    fontFamily: "Circular-Std",
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: <TargetPlatform, PageTransitionsBuilder>{
        TargetPlatform.android: SharedAxisPageTransitionsBuilder(
          transitionType: SharedAxisTransitionType.scaled,
        ),
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
