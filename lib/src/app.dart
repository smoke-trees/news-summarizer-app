import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/ui/pages/auth_page.dart';
import 'package:news_summarizer/src/ui/pages/base_page.dart';
import 'package:news_summarizer/src/ui/pages/blogs_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/custom_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/get_location_page.dart';
import 'package:news_summarizer/src/ui/pages/home_page.dart';
import 'package:news_summarizer/src/ui/pages/onboarding_pages.dart';
import 'package:news_summarizer/src/ui/pages/phone_auth_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_page.dart';
import 'package:news_summarizer/src/ui/pages/reorder_prefs_page.dart';
import 'package:news_summarizer/src/utils/shared_prefs.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return GetMaterialApp(
      title: 'News Summarizer',
      theme: themeProvider.theme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              bool isLoggedIn = ProfileHive().getIsUserLoggedIn();
              if (isLoggedIn == false) {
                return AuthPage();
              } else {
                return BasePage();
              }
            } else {
              return Scaffold(
                backgroundColor: Theme.of(context).primaryColor,
                body: Center(
                  child: Text(
                    "News Summarizer",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              );
            }
          }),
      routes: {
        HomeWidget.routename: (context) => HomeWidget(),
        BasePage.routename: (context) => BasePage(),
        PreferencesPage.routename: (context) => PreferencesPage(),
        CustomPrefsPage.routename: (context) => CustomPrefsPage(),
        ReorderPrefsPage.routeName: (context) => ReorderPrefsPage(),
        BlogsPrefsPage.routeName: (context) => BlogsPrefsPage(),
        OnboardingPages.routeName: (context) => OnboardingPages(),
        PhoneAuthPage.routeName: (context) => PhoneAuthPage(),
        GetLocationPage.routeName: (context) => GetLocationPage(),
      },
    );
  }
}
