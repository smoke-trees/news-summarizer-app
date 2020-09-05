import 'package:flutter/material.dart';
import 'package:news_summarizer/src/ui/pages/news_page.dart';

class NewsContainerPage extends StatefulWidget {
  @override
  _NewsContainerPageState createState() => _NewsContainerPageState();
}

class _NewsContainerPageState extends State<NewsContainerPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
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
            tabs: [
              Tab(text: "MOST RECENT"),
              Tab(text: "INDIA"),
              Tab(text: "WORLD"),
            ],
            isScrollable: true,
          ),
        ),
        body: TabBarView(
          children: [
            NewsPage(),
            NewsPage(),
            NewsPage(),
          ],
        ),
      ),
    );
  }
}
