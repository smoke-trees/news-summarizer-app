import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/ui/pages/reorder_news_prefs_page.dart';

class ReorderPrefsOnboardingPage extends StatefulWidget {
  static String routeName = "/reorder_onboarding_page";

  @override
  _ReorderPrefsOnboardingPageState createState() => _ReorderPrefsOnboardingPageState();
}

class _ReorderPrefsOnboardingPageState extends State<ReorderPrefsOnboardingPage> {
  double opacity = 0.0;
  double buttonOpacity = 0.0;
  final Widget svg = SvgPicture.asset(
    "assets/svgs/reorder.svg",
    semanticsLabel: 'Reorder SVG',
    // color: Get.theme.accentColor,
    width: Get.mediaQuery.size.width,
    fit: BoxFit.contain,
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
            Get.toNamed(ReorderNewsPrefsPage.routeName, arguments: true);
          }));
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: svg,
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "You can arrange your channels in the order you want to see them.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Just drag and position the channels in your desired order.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
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
            //         Get.toNamed(ReorderPrefsPage.routeName, arguments: true);
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
            //               fontWeight: FontWeight.bold,
            //               fontSize: 16,
            //               color: Get.theme.accentColor
            //             ),
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
