import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/ui/pages/blogs_onboarding_page.dart';
import 'package:news_summarizer/src/ui/widgets/listview_card.dart';
import 'package:news_summarizer/src/utils/constants.dart';

class ReorderNewsPrefsPage extends StatefulWidget {
  static String routeName = "/reorder_news_prefs_page";

  @override
  _ReorderNewsPrefsPageState createState() => _ReorderNewsPrefsPageState();
}

class _ReorderNewsPrefsPageState extends State<ReorderNewsPrefsPage> {
  bool isNewUser = Get.arguments ?? false;
  var _newsBox = Hive.box(NEWS_PREFS_BOX);
  var preferences = [];

  @override
  void initState() {
    super.initState();
    preferences = _newsBox.get(NEWS_PREFS) ?? [];
    // preferences = preferences.map((e) => e.toString()).toList();
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        var item = preferences.removeAt(oldIndex);
        preferences.insert(newIndex, item);
      },
    );
  }

  void finishReordering() {
    _newsBox.put(NEWS_PREFS, preferences);
    if (isNewUser) {
      Get.toNamed(BlogsOnboardingPage.routeName);
    } else {
      // Get.toNamed(BlogsPrefsPage.routeName);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Re-order News Channels',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Get.theme.accentColor,
          ),
        ),
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
            onTap: () => finishReordering(),
          ),
        ],
      ),
      body: Theme(
        data: ThemeData(canvasColor: Get.theme.scaffoldBackgroundColor),
        child: ReorderableListView(
          header: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
            child: Text(
              "Reorder the news channels according to your level of interest!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          onReorder: _onReorder,
          children: List.generate(
            preferences.length,
            (index) {
              return ListViewCard(
                preferences.map((e) => e.toString()).toList(),
                index,
                Key('$index'),
              );
            },
          ),
        ),
      ),
    );
  }
}
