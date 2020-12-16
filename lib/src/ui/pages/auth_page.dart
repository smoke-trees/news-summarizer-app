import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/models/user.dart';
import 'package:news_summarizer/src/providers/auth_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/phone_auth_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_onboarding_page.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:news_summarizer/src/utils/hive_prefs.dart';
import 'package:provider/provider.dart';

import 'base_page.dart';

class AuthPage extends StatefulWidget {
  static String routeName = "/auth_page";
  final bool firstLogin;

  AuthPage({this.firstLogin = false});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  var _newsBox = Hive.box(NEWS_PREFS_BOX);

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
        backgroundColor: Get.theme.backgroundColor,
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text(
        //     'Terran Tidings',
        //     style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Get.theme.accentColor),
        //   ),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.tonality),
        //     onPressed: () {
        //       themeProvider.toggleTheme();
        //     },
        //   ),
        // ],
        // ),
        body: userProvider.user != null && userProvider.user.firebaseUid != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Logged in with:  ", style: TextStyle(fontSize: 18)),
                      Text(
                        "${userProvider.user.email ?? userProvider.user.phoneNumber}",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  )
                ],
              )
            : Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        // padding: EdgeInsets.only(top: 100),
                        child: Text(
                          "Save all your channels by logging in:",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
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
                            AuthProvider authProvider = Provider.of<AuthProvider>(context, listen: false);
                            UserCredential credential = await authProvider.autoSignInGoogle();
                            if (credential.additionalUserInfo.isNewUser) {
                              // ApiUser user = userProvider.createNewUser(newUser: credential.user);
                              userProvider.user.name = credential.user.displayName;
                              userProvider.user.email = credential.user.email;
                              userProvider.user.firebaseUid = credential.user.uid;
                              userProvider.user.photoUrl = credential.user.photoURL;

                              userProvider.createUserInFirebase(newUser: userProvider.user);
                              userProvider.saveToHive(user: userProvider.user);
                              print(userProvider.user.toJson());
                              // userProvider.setUserInProvider(setUser: use)
                              Get.offAndToNamed(BasePage.routeName);
                              Get.snackbar(
                                  "Successful",
                                  userProvider.user.name == null
                                      ? "Welcome!"
                                      : "Welcome, ${userProvider.user.name}!",
                                  snackPosition: SnackPosition.BOTTOM);
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
                              Get.toNamed(BasePage.routeName);
                              Get.snackbar(
                                  "Successful",
                                  userProvider.user.name == null
                                      ? "Welcome back!"
                                      : "Welcome back, ${userProvider.user.name}!",
                                  snackPosition: SnackPosition.BOTTOM);
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
                  widget.firstLogin
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            padding: EdgeInsets.only(bottom: 30),
                            // alignment: Alignment.bottomCenter,
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
                          ),
                        )
                      : SizedBox.shrink()
                ],
              ));
  }
}
