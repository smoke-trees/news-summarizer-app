import 'package:flutter/material.dart';
import 'package:news_summarizer/src/utils/html_utils.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:http/http.dart' as http;

class NewsPage extends StatefulWidget {
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  static const String FEED_URL =
      'https://timesofindia.indiatimes.com/rssfeeds/1221656.cms';
  RssFeed _feed;

  Future<RssFeed> loadFeed() async {
    try {
      final client = http.Client();
      final response = await client.get(FEED_URL);
      return RssFeed.parse(response.body);
    } catch (e) {
      //
    }
    return null;
  }

  load() async {
    loadFeed().then((result) {
      if (null == result || result.toString().isEmpty) {
        print("Error");
        return;
      }
      var imageUrl = getImageUrl(result.items[0].description);
      print(imageUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    load();
    return Container();
  }
}
