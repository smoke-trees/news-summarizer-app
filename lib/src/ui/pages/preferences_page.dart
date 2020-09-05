import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';

class PreferencesPage extends StatefulWidget {
  static const routename = "/preferences";

  @override
  _PreferencesPageState createState() => _PreferencesPageState();
}

class _PreferencesPageState extends State<PreferencesPage> {
  List<NewsFeed> popularChosen = [];
  List<NewsFeed> metroChosen = [];
  List<NewsFeed> indianCitiesChosen = [];
  List<NewsFeed> internationalChosen = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News Preferences',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24),
            Container(
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
            SizedBox(height: 16),
            ChipsChoice<NewsFeed>.multiple(
              itemConfig: ChipsChoiceItemConfig(
                selectedColor: Theme.of(context).accentColor,
                unselectedColor: Theme.of(context).cardColor,
                unselectedBrightness: Theme.of(context).brightness,
                selectedBrightness: Theme.of(context).brightness,
              ),
              value: popularChosen,
              options: ChipsChoiceOption.listFrom(
                source: NewsFeed.values.sublist(0, 14),
                value: (index, item) => item,
                label: (index, item) =>
                    item.toString().split(".").last.replaceAll("_", " "),
              ),
              onChanged: (val) {
                setState(() => popularChosen = val);
              },
              padding: EdgeInsets.all(8),
              isWrapped: true,
            ),
            SizedBox(height: 32),
            Container(
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
            SizedBox(height: 16),
            ChipsChoice<NewsFeed>.multiple(
              itemConfig: ChipsChoiceItemConfig(
                selectedColor: Theme.of(context).accentColor,
                unselectedColor: Theme.of(context).cardColor,
                unselectedBrightness: Theme.of(context).brightness,
                selectedBrightness: Theme.of(context).brightness,
              ),
              value: internationalChosen,
              options: ChipsChoiceOption.listFrom(
                source: NewsFeed.values.sublist(46, 53),
                value: (index, item) => item,
                label: (index, item) =>
                    item.toString().split(".").last.replaceAll("_", " "),
              ),
              onChanged: (val) {
                setState(() => internationalChosen = val);
              },
              padding: EdgeInsets.all(8),
              isWrapped: true,
            ),
            SizedBox(height: 32),
            Container(
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
            SizedBox(height: 16),
            ChipsChoice<NewsFeed>.multiple(
              itemConfig: ChipsChoiceItemConfig(
                selectedColor: Theme.of(context).accentColor,
                unselectedColor: Theme.of(context).cardColor,
                unselectedBrightness: Theme.of(context).brightness,
                selectedBrightness: Theme.of(context).brightness,
              ),
              value: metroChosen,
              options: ChipsChoiceOption.listFrom(
                source: NewsFeed.values.sublist(14, 19),
                value: (index, item) => item,
                label: (index, item) =>
                    item.toString().split(".").last.replaceAll("_", " "),
              ),
              onChanged: (val) {
                setState(() => metroChosen = val);
              },
              padding: EdgeInsets.all(8),
              isWrapped: true,
            ),
            SizedBox(height: 32),
            Container(
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
            SizedBox(height: 16),
            ChipsChoice<NewsFeed>.multiple(
              itemConfig: ChipsChoiceItemConfig(
                selectedColor: Theme.of(context).accentColor,
                unselectedColor: Theme.of(context).cardColor,
                unselectedBrightness: Theme.of(context).brightness,
                selectedBrightness: Theme.of(context).brightness,
              ),
              value: indianCitiesChosen,
              options: ChipsChoiceOption.listFrom(
                source: NewsFeed.values.sublist(19, 46),
                value: (index, item) => item,
                label: (index, item) =>
                    item.toString().split(".").last.replaceAll("_", " "),
              ),
              onChanged: (val) {
                setState(() => indianCitiesChosen = val);
              },
              padding: EdgeInsets.all(8),
              isWrapped: true,
            ),
            SizedBox(height: 56),
          ],
        ),
      ),
    );
  }
}
