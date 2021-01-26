import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/ui/pages/preferences_page.dart';

class PreferencesOnboardingPage extends StatefulWidget {
  static String routeName = "/prefs_onboarding_page";

  @override
  _PreferencesOnboardingPageState createState() =>
      _PreferencesOnboardingPageState();
}

class _PreferencesOnboardingPageState extends State<PreferencesOnboardingPage> {
  double opacity = 0.0;
  double buttonOpacity = 0.0;
  final Widget svg = SvgPicture.asset(
    "assets/svgs/select.svg",
    semanticsLabel: 'Selection Logo',
    // color: Get.theme.accentColor,
    width: Get.mediaQuery.size.width - 20,
    height: Get.mediaQuery.size.height * 0.25,
    fit: BoxFit.contain,
    placeholderBuilder: (context) {
      return Center(child: CircularProgressIndicator());
    },
  );

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        opacity = 1.0;
      });
    });
    Future.delayed(Duration(seconds: 1, milliseconds: 500), () {
      setState(() {
        buttonOpacity = 1.0;
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
          }).whenComplete(() => Future.delayed(Duration(milliseconds: 500), () {
                Get.toNamed(PreferencesPage.routeName, arguments: true);
              }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            svg,
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Welcome to your own personalized tidings from across the world.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Create your own news channels, or pick from our curated list.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(20),
            //   child: Text(
            //     "",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(fontSize: 20),
            //   ),
            // ),
            // SizedBox(
            //   height: 25,
            // ),
            // AnimatedOpacity(
            //   opacity: buttonOpacity,
            //   duration: Duration(milliseconds: 500),
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            //     child: OutlineButton(
            //       onPressed: () async {
            //         Get.toNamed(PreferencesPage.routeName, arguments: true);
            //       },
            //       padding: EdgeInsets.symmetric(vertical: 14),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(10),
            //       ),
            //       borderSide: BorderSide(color: Color(0xff3B916E)),
            //       highlightedBorderColor: Colors.transparent,
            //       child: Row(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           Text(
            //             "Continue",
            //             style: TextStyle(
            //                 fontWeight: FontWeight.bold, fontSize: 16, color: Get.theme.accentColor),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
