import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/ui/widgets/news_card.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  final NewsFeed newsFeed;

  NewsPage(this.newsFeed);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with AutomaticKeepAliveClientMixin<NewsPage> {
  List<Article> _newsItems;
  Future<List<Article>> _getFeed;

  @override
  void initState() {
    _getFeed = loadFeed();
    super.initState();
  }

  Future<List<Article>> loadFeed() async {
    try {
      ApiProvider apiProvider = Provider.of<ApiProvider>(context, listen: false);
      String category = widget.newsFeed.toString().split('.').last;
      List<Article> articleList = await apiProvider.getArticlesFromCategory(category: category);
      _newsItems = articleList;
      return articleList;
    } on SocketException {
      Get.snackbar(
        "Error",
        "No Internet!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: FutureBuilder(
        future: _getFeed,
        builder: (context, snapshot) => (snapshot.hasData)
            ? RefreshIndicator(
                onRefresh: loadFeed,
                backgroundColor: Theme.of(context).primaryColor,
                child: snapshot.data.length == 0
                    ? Center(
                        child: Text("No news available"),
                      )
                    : ListView.builder(
                        itemBuilder: (context, index) => NewsCard(
                          article: _newsItems[index],
                        ),
                        itemCount: _newsItems.length,
                      ),
              )
            : Center(
                child: Text("Fetching latest news for you..."),
              ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
