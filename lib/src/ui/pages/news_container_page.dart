import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/ui/pages/news_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_page.dart';
import 'package:news_summarizer/src/ui/widgets/theme_dialog.dart';
import 'package:news_summarizer/src/utils/constants.dart';

class NewsContainerPage extends StatefulWidget {
  @override
  _NewsContainerPageState createState() => _NewsContainerPageState();
}

class _NewsContainerPageState extends State<NewsContainerPage>
    with AutomaticKeepAliveClientMixin<NewsContainerPage> {
  var _newsFeeds;

  @override
  void initState() {
    super.initState();
    _getNewsFromHive();
  }

  _getNewsFromHive() async {
    var newsBox = Hive.box(NEWS_PREFS_BOX);
    _newsFeeds = newsBox.get(NEWS_PREFS);
  }

  Future<void> _showThemeDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ThemeDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: _newsFeeds.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          leading: Icon(Icons.search),
          title: Text(
            'News',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
            ),
          ),
          actions: [
            PopupMenuButton(
              onSelected: (value) async {
                switch (value) {
                  case 'Change Theme':
                    _showThemeDialog(context);
                    break;
                  case 'Change News Preferences':
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PreferencesPage(),
                      ),
                    );
                    break;
                }
              },
              itemBuilder: (context) {
                return {'Change Theme', 'Change News Preferences'}
                    .map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
          bottom: TabBar(
            tabs: List.generate(
              _newsFeeds.length,
              (index) => Tab(
                text: _newsFeeds[index]
                    .toString()
                    .split('.')
                    .last
                    .replaceAll("_", " "),
              ),
            ),
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: List.generate(
            _newsFeeds.length,
            (index) => NewsPage(_newsFeeds[index]),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
