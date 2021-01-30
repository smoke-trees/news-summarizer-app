import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/ui/pages/auth_page.dart';
import 'package:news_summarizer/src/ui/widgets/onboarding_text_widget.dart';

class AuthOnboardingPage extends StatefulWidget {
  static String routeName = "/new_prefs_onboarding_page";

  @override
  _AuthOnboardingPageState createState() => _AuthOnboardingPageState();
}

class _AuthOnboardingPageState extends State<AuthOnboardingPage> {
  double opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedOpacity(
        duration: Duration(milliseconds: 500),
        opacity: opacity,
        onEnd: () {
          Future.delayed(Duration(seconds: 3), () {
            // setState(() {
            //   opacity = 0.0;
            // });
          })
              .whenComplete(
            () => Future.delayed(Duration(milliseconds: 500), () {
              // Get.toNamed(AuthPage.routeName, arguments: true);
              Get.to(AuthPage(
                firstLogin: true,
              ));
            }),
          );
        },
        child: Container(
          width: Get.width,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  "assets/splash_bg.png",
                ),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: Container(
                    padding: EdgeInsets.only(top: 50),
                    child: Text(
                      "Welcome To Terran Tidings",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Your gateway to news in the world",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      "assets/icons/dark-logo.png",
                      width: Get.width * 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
