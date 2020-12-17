import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/ui/pages/auth_page.dart';
import 'package:news_summarizer/src/ui/pages/base_page.dart';
import 'package:news_summarizer/src/ui/pages/blogs_onboarding_page.dart';
import 'package:news_summarizer/src/ui/pages/blogs_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/control_center.dart';
import 'package:news_summarizer/src/ui/pages/custom_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/get_location_page.dart';
import 'package:news_summarizer/src/ui/pages/home_page.dart';
import 'package:news_summarizer/src/ui/pages/notifs_checklist_page.dart';
import 'package:news_summarizer/src/ui/pages/onboarding_pages.dart';
import 'package:news_summarizer/src/ui/pages/phone_auth_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_onboarding_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_page.dart';
import 'package:news_summarizer/src/ui/pages/reorder_prefs_onboarding_page.dart';
import 'package:news_summarizer/src/ui/pages/reorder_prefs_page.dart';
import 'package:news_summarizer/src/utils/hive_prefs.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return GetMaterialApp(
      title: 'Terran Tidings',
      theme: themeProvider.theme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: Firebase.initializeApp(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              bool isLoggedIn = ProfileHive().getIsUserLoggedIn();
              if (isLoggedIn == false) {
                return AuthPage(firstLogin: true,);
              } else {
                return BasePage();
              }
            } else {
              return Scaffold(
                backgroundColor: Get.theme.primaryColor,
                body: Center(
                  child: Text(
                    "Terran Tidings",
                    style: TextStyle(fontSize: 24),
                  ),
                ),
              );
            }
          }),
      // getPages: [
      //   GetPage(
      //       name: PreferencesOnboardingPage.routeName,
      //       page: () => PreferencesOnboardingPage(),
      //       // transition: Transition.noTransition,
      //       // transitionDuration: Duration(seconds: 1)
      //   ),
      // ],
      routes: {
        HomeWidget.routename: (context) => HomeWidget(),
        BasePage.routeName: (context) => BasePage(),
        PreferencesPage.routeName: (context) => PreferencesPage(),
        CustomPrefsPage.routename: (context) => CustomPrefsPage(),
        ReorderPrefsPage.routeName: (context) => ReorderPrefsPage(),
        BlogsPrefsPage.routeName: (context) => BlogsPrefsPage(),
        OnboardingPages.routeName: (context) => OnboardingPages(),
        PhoneAuthPage.routeName: (context) => PhoneAuthPage(),
        GetLocationPage.routeName: (context) => GetLocationPage(),
        NotifsChecklistPage.routeName: (context) => NotifsChecklistPage(),
        PreferencesOnboardingPage.routeName: (context) => PreferencesOnboardingPage(),
        ReorderPrefsOnboardingPage.routeName: (context) => ReorderPrefsOnboardingPage(),
        BlogsOnboardingPage.routeName: (context) => BlogsOnboardingPage(),
        AuthPage.routeName: (context) => AuthPage(),
        ControlCenterPage.routeName: (context) => ControlCenterPage(),
      },
    );
  }
}
