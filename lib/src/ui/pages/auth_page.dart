import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/models/user.dart';
import 'package:news_summarizer/src/providers/auth_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/onboarding_pages.dart';
import 'package:news_summarizer/src/ui/pages/phone_auth_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_onboarding_page.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:news_summarizer/src/utils/hive_prefs.dart';
import 'package:provider/provider.dart';

import 'base_page.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var _newsBox = Hive.box(NEWS_PREFS_BOX);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News Summarizer',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Get.theme.accentColor),
        ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.tonality),
        //     onPressed: () {
        //       themeProvider.toggleTheme();
        //     },
        //   ),
        // ],
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) => (snapshot.connectionState == ConnectionState.done)
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(child: SizedBox.shrink()),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(top: 100),
                        child: Text(
                          "Let's get you started!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: OutlineButton(
                          onPressed: () {
                            Get.toNamed(PhoneAuthPage.routeName);
                          },
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          borderSide: BorderSide(color: Color(0xff3B916E)),
                          highlightedBorderColor: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.phone),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                "Continue with Phone Number",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      //   child: OutlineButton(
                      //     onPressed: () {
                      //       Get.toNamed(PhoneAuthPage.routeName);
                      //     },
                      //     padding: EdgeInsets.symmetric(vertical: 14),
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(10),
                      //     ),
                      //     borderSide: BorderSide(color: Color(0xff3B916E)),
                      //     highlightedBorderColor: Colors.transparent,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Icon(Icons.mail),
                      //         SizedBox(
                      //           width: 18,
                      //         ),
                      //         Text(
                      //           "Continue with Email",
                      //           style: TextStyle(
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 16,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: OutlineButton(
                          onPressed: () async {
                            UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
                            AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
                            UserCredential credential = await authProvider.autoSignInGoogle();
                            if (credential.additionalUserInfo.isNewUser) {
                              userProvider.createNewUser(newUser: credential.user);
                              Get.offAndToNamed(PreferencesOnboardingPage.routeName);
                            } else {
                              print("[] Old User but not in Hive");
                              ApiUser userr =
                                  await userProvider.getUserFromFirebase(firebaseUid: credential.user.uid);
                              userProvider.setUserInProvider(setUser: userr);
                              userProvider.saveToHive(user: userr);
                              _newsBox.put(NEWS_PREFS, userr.newsPreferences);
                              _newsBox.put(NEWS_BLOGS_AUTHORS, userr.blogPreferences);
                              _newsBox.put(NEWS_CUSTOM, userr.customPreferences);
                              ProfileHive().setIsUserLoggedIn(true);
                              Get.toNamed(BasePage.routename);
                            }
                          },
                          padding: EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          borderSide: BorderSide(color: Color(0xff3B916E)),
                          highlightedBorderColor: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "assets/icons/google_logo.png",
                                width: 20,
                                height: 20,
                              ),
                              SizedBox(
                                width: 18,
                              ),
                              Text(
                                "Continue with Google",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.only(bottom: 30),
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
                        ApiUser user = new ApiUser(
                            blogPreferences: [],
                            notifEnabledPrefs: [],
                            customPreferences: [],
                            newsPreferences: []);
                        userProvider.setUserInProvider(setUser: user);
                        userProvider.saveToHive(user: user);
                        Get.offAndToNamed(PreferencesOnboardingPage.routeName);
                      },
                      child: Text(
                        "Or skip for now",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Get.theme.accentColor,
                            decorationThickness: 3),
                      ),
                    ),
                  )
                ],
              )
            : Container(),
      ),
    );
  }
}
