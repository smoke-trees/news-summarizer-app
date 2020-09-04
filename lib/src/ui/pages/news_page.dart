import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/ui/widgets/news_card.dart';
import 'package:news_summarizer/src/utils/html_utils.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;
import 'package:webfeed/domain/rss_item.dart';

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  String _feedUrl = FeedUrlMap[NewsFeed.INDIA];
  List<RssItem> _newsItems;

  Future<List<RssItem>> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(_feedUrl);
      var result = RssFeed.parse(response.body);
      if (result == null || result.toString().isEmpty) {
        return null;
      }
      setState(() {
        _newsItems = result.items;
      });
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
        future: loadFeed(),
        builder: (context, snapshot) => (snapshot.hasData)
            ? ListView.builder(
                itemBuilder: (context, index) => NewsCard(
                  newsItem: _newsItems[index],
                ),
                itemCount: _newsItems.length,
              )
            : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
