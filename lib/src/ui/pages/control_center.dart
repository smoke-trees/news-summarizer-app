import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/base_page.dart';
import 'package:news_summarizer/src/ui/pages/blogs_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_page.dart';
import 'package:news_summarizer/src/ui/pages/pub_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/reorder_expert_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/reorder_news_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/reorder_pubs_prefs_page.dart';
import 'package:provider/provider.dart';

class ControlCenterPage extends StatefulWidget {
  static String routeName = "/control_center_page";

  @override
  _ControlCenterPageState createState() => _ControlCenterPageState();
}

class _ControlCenterPageState extends State<ControlCenterPage> {
  bool isNewUser = Get.arguments;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 16),
              alignment: Alignment.center,
              child: Text(
                "Done",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            onTap: () => Get.toNamed(BasePage.routeName),
          ),
        ],
        title: Text(
          "Control Center",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Get.theme.accentColor,
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "News Preferences",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Get.theme.accentColor,
                  decorationThickness: 3,
                ),
              ),
            ),
            subtitle: userProvider.user.newsPreferences.length == 0
                ? null
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(userProvider.user.newsPreferences
                            .map((e) => e
                                .substring(9)
                                .toLowerCase()
                                .split("_")
                                .map((e) => e.capitalizeFirst)
                                .join(" "))
                            .join(", ") ??
                        ""),
                  ),
            onTap: () {
              Get.toNamed(PreferencesPage.routeName);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Expert Opinion",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Get.theme.accentColor,
                  decorationThickness: 3,
                ),
              ),
            ),
            subtitle: userProvider.user.blogPreferences.length == 0
                ? null
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                        userProvider.user.blogPreferences?.join(", ") ?? ""),
                  ),
            onTap: () {
              Get.toNamed(BlogsPrefsPage.routeName);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Publications",
                style: TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Get.theme.accentColor,
                    decorationThickness: 3),
              ),
            ),
            subtitle: userProvider.user.pubPreferences.length == 0
                ? null
                : Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                        userProvider.user.pubPreferences?.join(", ") ?? ""),
                  ),
            onTap: () {
              Get.toNamed(PublicationPrefsPage.routeName);
            },
          ),
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "News Ordering",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Get.theme.accentColor,
                  decorationThickness: 3,
                ),
              ),
            ),
            // subtitle: Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //   child: Text(userProvider.user.blogPreferences.join(" ")),
            // ),
            onTap: () {
              Get.toNamed(ReorderNewsPrefsPage.routeName);
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Publication Ordering",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Get.theme.accentColor,
                  decorationThickness: 3,
                ),
              ),
            ),
            // subtitle: Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //   child: Text(userProvider.user.blogPreferences.join(" ")),
            // ),
            onTap: () {
              Get.toNamed(ReorderPubPrefsPage.routeName);
            },
          ),
          ListTile(
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Expert Opinion Ordering",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  decorationColor: Get.theme.accentColor,
                  decorationThickness: 3,
                ),
              ),
            ),
            // subtitle: Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            //   child: Text(userProvider.user.blogPreferences.join(" ")),
            // ),
            onTap: () {
              Get.toNamed(ReorderExpertPrefsPage.routeName);
            },
          ),
        ],
      ),
    );
  }
}
