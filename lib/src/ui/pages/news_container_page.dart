import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/ui/pages/news_page.dart';
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: _newsFeeds.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'News',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor,
            ),
          ),
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
