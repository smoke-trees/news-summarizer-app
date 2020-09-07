import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/ui/pages/base_page.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';
import 'package:news_summarizer/src/utils/shared_prefs.dart';

class PreferencesPage extends StatefulWidget {
  static const routename = "/preferences";

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  var _newsBox = Hive.box(NEWS_PREFS_BOX);

  var popularChosen = [];
  var metroChosen = [];
  var indianCitiesChosen = [];
  var internationalChosen = [];

  @override
  void initState() {
    super.initState();
    popularChosen = _newsBox.get(NEWS_POPULAR);
    metroChosen = _newsBox.get(NEWS_METRO);
    indianCitiesChosen = _newsBox.get(NEWS_OTHER);
    internationalChosen = _newsBox.get(NEWS_INT);
  }

  void finishSelection() async {
    print("finishSelection called");
    var finList = [];
    if (!popularChosen.isNullOrBlank) {
      finList.addAll(popularChosen);
    }
    if (!metroChosen.isNullOrBlank) {
      finList.addAll(metroChosen);
    }
    if (!indianCitiesChosen.isNullOrBlank) {
      finList.addAll(indianCitiesChosen);
    }
    if (!internationalChosen.isNullOrBlank) {
      finList.addAll(internationalChosen);
    }
    if (finList.length < 3) {
      Get.snackbar(
        "Warning!",
        "Please choose at least 3 categories.",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      _newsBox.put(NEWS_PREFS, finList);
      _newsBox.put(NEWS_POPULAR, popularChosen);
      _newsBox.put(NEWS_INT, internationalChosen);
      _newsBox.put(NEWS_METRO, metroChosen);
      _newsBox.put(NEWS_OTHER, indianCitiesChosen);
      SharedPrefs.setIsUserLoggedIn(true);
      Navigator.pushNamedAndRemoveUntil(
        context,
        BasePage.routename,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'News Preferences',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
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
            onTap: () => finishSelection(),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 24),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.all(16),
                child: Text(
                  "Pick the categories that interest you!",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 12),
              /*

              Popular Card

              */
              Container(
                margin: EdgeInsets.all(8),
                child: Card(
                  color: Theme.of(context).cardColor,
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    title: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Popular",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    children: [
                      ChipsChoice<dynamic>.multiple(
                        itemConfig: ChipsChoiceItemConfig(
                          selectedColor: Theme.of(context).accentColor,
                          unselectedColor: Theme.of(context).primaryColor,
                          unselectedBrightness: Theme.of(context).brightness,
                          selectedBrightness: Theme.of(context).brightness,
                        ),
                        value: popularChosen,
                        options: ChipsChoiceOption.listFrom(
                          source: NewsFeed.values.sublist(0, 14),
                          value: (index, item) => item,
                          label: (index, item) => item
                              .toString()
                              .split(".")
                              .last
                              .replaceAll("_", " "),
                        ),
                        onChanged: (val) {
                          setState(() => popularChosen = val);
                        },
                        padding: EdgeInsets.all(8),
                        isWrapped: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              /*

              International

              */
              Container(
                margin: EdgeInsets.all(8),
                child: Card(
                  color: Theme.of(context).cardColor,
                  child: ExpansionTile(
                    title: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "International",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    children: [
                      ChipsChoice<dynamic>.multiple(
                        itemConfig: ChipsChoiceItemConfig(
                          selectedColor: Theme.of(context).accentColor,
                          unselectedColor: Theme.of(context).primaryColor,
                          unselectedBrightness: Theme.of(context).brightness,
                          selectedBrightness: Theme.of(context).brightness,
                        ),
                        value: internationalChosen,
                        options: ChipsChoiceOption.listFrom(
                          source: NewsFeed.values.sublist(46, 53),
                          value: (index, item) => item,
                          label: (index, item) => item
                              .toString()
                              .split(".")
                              .last
                              .replaceAll("_", " "),
                        ),
                        onChanged: (val) {
                          setState(() => internationalChosen = val);
                        },
                        padding: EdgeInsets.all(8),
                        isWrapped: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              /*

              Metro Cities Card

              */
              Container(
                margin: EdgeInsets.all(8),
                child: Card(
                  color: Theme.of(context).cardColor,
                  child: ExpansionTile(
                    title: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Metro Cities",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    children: [
                      ChipsChoice<dynamic>.multiple(
                        itemConfig: ChipsChoiceItemConfig(
                          selectedColor: Theme.of(context).accentColor,
                          unselectedColor: Theme.of(context).primaryColor,
                          unselectedBrightness: Theme.of(context).brightness,
                          selectedBrightness: Theme.of(context).brightness,
                        ),
                        value: metroChosen,
                        options: ChipsChoiceOption.listFrom(
                          source: NewsFeed.values.sublist(14, 19),
                          value: (index, item) => item,
                          label: (index, item) => item
                              .toString()
                              .split(".")
                              .last
                              .replaceAll("_", " "),
                        ),
                        onChanged: (val) {
                          setState(() => metroChosen = val);
                        },
                        padding: EdgeInsets.all(8),
                        isWrapped: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 8),
              /*

              Other Cities Card

              */
              Container(
                margin: EdgeInsets.all(8),
                child: Card(
                  color: Theme.of(context).cardColor,
                  child: ExpansionTile(
                    title: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Other Cities",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          decoration: TextDecoration.underline,
                          decorationColor: Theme.of(context).accentColor,
                        ),
                      ),
                    ),
                    children: [
                      ChipsChoice<dynamic>.multiple(
                        itemConfig: ChipsChoiceItemConfig(
                          selectedColor: Theme.of(context).accentColor,
                          unselectedColor: Theme.of(context).primaryColor,
                          unselectedBrightness: Theme.of(context).brightness,
                          selectedBrightness: Theme.of(context).brightness,
                        ),
                        value: indianCitiesChosen,
                        options: ChipsChoiceOption.listFrom(
                          source: NewsFeed.values.sublist(19, 46),
                          value: (index, item) => item,
                          label: (index, item) => item
                              .toString()
                              .split(".")
                              .last
                              .replaceAll("_", " "),
                        ),
                        onChanged: (val) {
                          setState(() => indianCitiesChosen = val);
                        },
                        padding: EdgeInsets.all(8),
                        isWrapped: true,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 56),
            ],
          ),
        ),
      ),
    );
  }
}
