import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/ui/pages/blogs_prefs_page.dart';

class BlogsOnboardingPage extends StatefulWidget {
  static String routeName = "/blogs_onboarding_page";

  @override
  _BlogsOnboardingPageState createState() => _BlogsOnboardingPageState();
}

class _BlogsOnboardingPageState extends State<BlogsOnboardingPage> {
  double opacity = 0.0;
  double buttonOpacity = 0.0;
  final Widget svg = SvgPicture.asset(
    "assets/svgs/expert.svg",
    semanticsLabel: 'Expert SVG',
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
        // onEnd: () {
        //   Future.delayed(Duration(seconds: 2), () {
        //     setState(() {
        //       opacity = 0.0;
        //     });
        //   }).whenComplete(() => Future.delayed(Duration(milliseconds: 500), () {
        //         Get.toNamed(BlogsPrefsPage.routeName, arguments: true);
        //       }));
        // },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   "assets/svgs/expert.png",
            //   width: Get.mediaQuery.size.width,
            //   fit: BoxFit.contain,
            //
            // ),
            svg,
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                "Choose experts you follow, to read what they post.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            AnimatedOpacity(
              opacity: buttonOpacity,
              duration: Duration(milliseconds: 500),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: OutlineButton(
                  onPressed: () async {
                    Get.toNamed(BlogsPrefsPage.routeName, arguments: true);
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
                      Text(
                        "Continue",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Get.theme.accentColor),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
