import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/models/user.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/onboarding_pages.dart';
import 'package:news_summarizer/src/ui/pages/preferences_onboarding_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_page.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:news_summarizer/src/utils/hive_prefs.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';

import 'base_page.dart';

class PhoneAuthPage extends StatefulWidget {
  static String routeName = "/phone_auth_page";

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  final _formkey = GlobalKey<FormState>();
  bool _isLoading = false;
  bool _isOTPWidgetVisible = false;
  String _otpString = "";
  String _verificationCode;
  final TextEditingController _phoneController = TextEditingController();
  var _newsBox = Hive.box(NEWS_PREFS_BOX);

  Future<void> initPhoneAuth(BuildContext ctx) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    final PhoneVerificationFailed verificationFailed = (e) {
      setState(() {
        print(e.message);
        _isLoading = false;
      });
      Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    };

    final PhoneCodeSent codeSent = (String verificationId, [int forceResendingToken]) async {
      print("code sent");
      setState(() {
        _isLoading = false;
        _isOTPWidgetVisible = true;
        _verificationCode = verificationId;
      });
    };

    final PhoneVerificationCompleted verificationCompleted = (AuthCredential authCredential) async {
      try {
        UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
        var authResult = await _auth.signInWithCredential(authCredential);
        if (authResult.user != null && authResult.additionalUserInfo.isNewUser) {
          userProvider.createNewUser(newUser: authResult.user, phoneNumber: _phoneController.text.trim());
          // Navigator.popAndPushNamed(context, OnboardingPages.routeName);
          Get.toNamed(PreferencesOnboardingPage.routeName);
        } else {

          print("[] Old User but not in Hive");
          ApiUser userr = await userProvider.getUserFromFirebase(firebaseUid: authResult.user.uid);
          userProvider.setUserInProvider(setUser: userr);
          userProvider.saveToHive(user: userr);
          _newsBox.put(NEWS_PREFS, userr.newsPreferences);
          _newsBox.put(NEWS_BLOGS_AUTHORS, userr.blogPreferences);
          _newsBox.put(NEWS_CUSTOM, userr.customPreferences);
          ProfileHive().setIsUserLoggedIn(true);
          Navigator.popAndPushNamed(context, BasePage.routename);
        }
      } catch (e) {
        Get.snackbar(
          "Error",
          "Something went wrong!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    };

    setState(() {
      _isLoading = true;
    });
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91" + _phoneController.text,
      timeout: Duration(seconds: 90),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
        print("Timeout");
      },
    );
  }

  Future<void> signInPhoneNumber(String smsCode) async {
    final AuthCredential credential = PhoneAuthProvider.credential(
      verificationId: _verificationCode,
      smsCode: smsCode,
    );
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      setState(() {
        _isLoading = true;
      });
      var authResult = await FirebaseAuth.instance.signInWithCredential(credential);
      User user = authResult.user;
      if (user != null && authResult.additionalUserInfo.isNewUser) {
        setState(() {
          _isLoading = false;
        });
        userProvider.createNewUser(newUser: authResult.user, phoneNumber: _phoneController.text.trim());
        // Navigator.popAndPushNamed(context, OnboardingPages.routeName);
        Get.toNamed(PreferencesOnboardingPage.routeName);
      } else {
        print("[] Old User but not in Hive");
        ApiUser userr = await userProvider.getUserFromFirebase(firebaseUid: authResult.user.uid);
        userProvider.setUserInProvider(setUser: userr);
        userProvider.saveToHive(user: userr);
        _newsBox.put(NEWS_PREFS, userr.newsPreferences);
        _newsBox.put(NEWS_BLOGS_AUTHORS, userr.blogPreferences);
        _newsBox.put(NEWS_CUSTOM, userr.customPreferences);
        ProfileHive().setIsUserLoggedIn(true);
        Navigator.popAndPushNamed(context, BasePage.routename);
      }
    } on PlatformException catch (err) {
      if (err.code == "ERROR_INVALID_VERIFICATION_CODE") {
        Get.snackbar(
          "Error",
          "Invalid OTP",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        Get.snackbar(
          "Error",
          "Something went wrong!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      _isLoading = false;
      Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
          centerTitle: true,
          title: Text(
            'News Summarizer',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Get.theme.accentColor),
          )),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  TextFormField(
                    enabled: !_isOTPWidgetVisible,
                    validator: (value) {
                      if (value.length < 10) {
                        return 'Please enter a valid number!';
                      }
                      return null;
                    },
                    controller: _phoneController,
                    maxLength: 10,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Phone Number',
                      hintText: '8197513721',
                      icon: Icon(Icons.phone, color: Color(0xff3B916E)),
                    ),
                  ),
                  SizedBox(height: 8),
                  Visibility(
                    visible: _isOTPWidgetVisible,
                    child: InkWell(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Edit phone number",
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _isOTPWidgetVisible = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: _isOTPWidgetVisible,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 24,
                  ),
                  alignment: Alignment.centerLeft,
                  child: Text("Enter the OTP received"),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32),
                  child: PinCodeTextField(
                    animationType: AnimationType.slide,
                    textInputType: TextInputType.number,
                    length: 6,
                    backgroundColor: Colors.transparent,
                    enabled: !_isLoading,
                    textStyle: TextStyle(
                      color: (themeProvider.theme == themeProvider.darkTheme) ? Colors.white : Colors.black,
                      fontSize: 18,
                    ),
                    pinTheme: PinTheme(
                      selectedColor: Get.theme.accentColor,
                      activeColor: Get.theme.accentColor,
                      inactiveColor: Get.theme.accentColor,
                      fieldWidth: 40,
                    ),
                    onCompleted: (value) {
                      setState(() {
                        _otpString = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 40),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(24),
            width: 100,
            height: 45,
            child: MaterialButton(
              child: (!_isLoading)
                  ? Text(
                      "NEXT",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Get.theme.primaryColor,
                      ),
                    )
                  : Container(
                      height: 25,
                      width: 25,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.white,
                        ),
                      ),
                    ),
              disabledColor: Get.theme.accentColor.withOpacity(0.7),
              onPressed: (!_isLoading)
                  ? () {
                      if (_isOTPWidgetVisible) {
                        signInPhoneNumber(_otpString);
                      } else {
                        if (_formkey.currentState.validate()) {
                          initPhoneAuth(context);
                        }
                      }
                    }
                  : null,
              color: Get.theme.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
