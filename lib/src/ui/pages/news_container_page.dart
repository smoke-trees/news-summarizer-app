import 'package:flutter/material.dart';
import 'package:news_summarizer/src/ui/pages/news_page.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';

class NewsContainerPage extends StatefulWidget {
  @override
  _NewsContainerPageState createState() => _NewsContainerPageState();
}

class _NewsContainerPageState extends State<NewsContainerPage> {
  List<NewsFeed> _newsFeeds = [
    NewsFeed.ENTERTAINMENT,
    NewsFeed.SCIENCE,
    NewsFeed.ENVIRONMENT,
    NewsFeed.TECH,
    NewsFeed.EDUCATION,
  ];

  @override
  Widget build(BuildContext context) {
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
}
