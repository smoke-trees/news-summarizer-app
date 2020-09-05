import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/ui/widgets/news_card.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_item.dart';

class NewsPage extends StatefulWidget {
  final NewsFeed newsFeed;

  NewsPage(this.newsFeed);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String _feedUrl;
  List<RssItem> _newsItems;
  Future<void> _getFeed;

  @override
  void initState() {
    _feedUrl = FeedUrlMap[widget.newsFeed];
    _getFeed = loadFeed();
    super.initState();
  }

  Future<void> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(_feedUrl);
      var result = RssFeed.parse(response.body);
      if (result == null || result.toString().isEmpty) {
        Get.snackbar(
          "Error",
          "Looks like nothing here in the feed!",
          backgroundColor: Colors.orange,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
      setState(() {
        _newsItems = result.items;
      });
      print(result.items.length);
      return result.items;
    } catch (e) {
      Get.snackbar(
        "Error",
        "Something went wrong!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: _getFeed,
        builder: (context, snapshot) => (snapshot.hasData)
            ? RefreshIndicator(
                onRefresh: loadFeed,
                backgroundColor: Theme.of(context).cardColor,
                child: ListView.builder(
                  itemBuilder: (context, index) => NewsCard(
                    newsItem: _newsItems[index],
                  ),
                  itemCount: _newsItems.length,
                ),
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
