import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/ui/widgets/news_card.dart';
import 'package:news_summarizer/src/utils/article_type_enum.dart';
import 'package:provider/provider.dart';

class RecommendedNewsPage extends StatefulWidget {
  @override
  _RecommendedNewsPageState createState() => _RecommendedNewsPageState();
}

class _RecommendedNewsPageState extends State<RecommendedNewsPage>
    with AutomaticKeepAliveClientMixin<RecommendedNewsPage> {
  List<Article> _newsItems;

  @override
  bool get wantKeepAlive => true;

  Future<List<Article>> loadFeed() async {
    try {
      ApiProvider apiProvider =
          Provider.of<ApiProvider>(context, listen: false);
      _newsItems = await apiProvider.getRecommendedNews();
      return _newsItems;
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: loadFeed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: loadFeed,
              backgroundColor: Get.theme.primaryColor,
              child: snapshot.data.length == 0
                  ? Center(
                      child: Text("No news available"),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) => NewsCard(
                        article: _newsItems[index],
                        articleType: ArticleType.NEWS,
                      ),
                      itemCount: _newsItems.length,
                    ),
            );
          } else {
            return Center(
              child: Text("Fetching latest news for you..."),
            );
          }
        },
      ),
    );
  }
}
