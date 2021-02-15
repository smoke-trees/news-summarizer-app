import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/services/ip_service.dart';
import 'package:news_summarizer/src/ui/pages/control_center.dart';
import 'package:news_summarizer/src/ui/widgets/onboarding_text_widget.dart';

class ControlCenterOnboardingPage extends StatefulWidget {
  static String routeName = "/control_center_onboarding_page";

  @override
  _ControlCenterOnboardingPageState createState() =>
      _ControlCenterOnboardingPageState();
}

class _ControlCenterOnboardingPageState
    extends State<ControlCenterOnboardingPage> {
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
        opacity: opacity,
        duration: Duration(milliseconds: 500),
        onEnd: () {
          Future.delayed(Duration(seconds: 3), () {
            // setState(() {
            //   opacity = 0.0;
            // });
          })
              .whenComplete(
            () => Future.delayed(
              Duration(milliseconds: 500),
              () {
                IPService cs = new IPService();
                cs.getLocation(context);

                Get.offAllNamed(
                  ControlCenterPage.routeName,
                  arguments: true,
                );
                // Get.offAndToNamed(ControlCenterPage.routeName, arguments: true);
              },
            ),
          );
        },
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnboardingTextWidget(
              text: "You can now choose and create channels",
            ),
            SizedBox(
              height: 20,
            ),
            OnboardingTextWidget(
              text:
                  "You have the option of news channels, expert opinion channels and publications",
            )
          ],
        )),
      ),
    );
  }
}
