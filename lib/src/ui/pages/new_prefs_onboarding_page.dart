import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/ui/pages/auth_page.dart';
import 'package:news_summarizer/src/ui/widgets/onboarding_text_widget.dart';

class NewPrefsOnboardingPage extends StatefulWidget {
  static String routeName = "/new_prefs_onboarding_page";

  @override
  _NewPrefsOnboardingPageState createState() => _NewPrefsOnboardingPageState();
}

class _NewPrefsOnboardingPageState extends State<NewPrefsOnboardingPage> {
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
            setState(() {
              opacity = 0.0;
            });
          }).whenComplete(
            () => Future.delayed(Duration(milliseconds: 500), () {
              // Get.toNamed(AuthPage.routeName, arguments: true);
              Get.to(AuthPage(
                firstLogin: true,
              ));
            }),
          );
        },
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnboardingTextWidget(text: "Welcome to Terran Tidings"),
            SizedBox(
              height: 20,
            ),
            OnboardingTextWidget(
              text: "Your gateway to news and more across the globe",
            )
          ],
        )),
      ),
    );
  }
}
