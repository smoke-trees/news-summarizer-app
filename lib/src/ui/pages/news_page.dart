import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/widgets/news_card.dart';
import 'package:news_summarizer/src/utils/article_type_enum.dart';
import 'package:provider/provider.dart';

class NewsPage extends StatefulWidget {
  final String newsFeed;
  final String customPref;
  final String blogAuthor;
  final ArticleType articleType;

  NewsPage({this.newsFeed, this.customPref, this.blogAuthor, this.articleType});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> with AutomaticKeepAliveClientMixin<NewsPage> {
  List<Article> _newsItems;

  @override
  void initState() {
    super.initState();
  }

  Future<List<Article>> loadFeed() async {
    try {
      // print(widget.articleType);
      // print(widget.newsFeed);
      ApiProvider apiProvider = Provider.of<ApiProvider>(context, listen: false);
      UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
      if (widget.articleType == ArticleType.CUSTOM) {
        List<Article> articleList =
            await apiProvider.getArticlesFromCustomPreference(customPref: widget.customPref);
        _newsItems = articleList;
        return articleList;
      } else if (widget.articleType == ArticleType.EXPERT) {
        List<Article> articleList = await apiProvider.getArticlesFromBlogAuthor(author: widget.blogAuthor);
        _newsItems = articleList;
        return articleList;
      } else if (widget.articleType == ArticleType.AROUNDME) {
        List<Article> articleList = await apiProvider.getArticlesFromLocation(
            latitude: userProvider.user.latitude, longitude: userProvider.user.longitude);
        _newsItems = articleList;
        return articleList;
      } else if (widget.articleType == ArticleType.NEWS) {
        String category = widget.newsFeed.split('.').sublist(1).join("").replaceAll("_", " ");
        if (category == "USA") {
          category = "U.S.A";
        }
        List<Article> articleList = await apiProvider.getArticlesFromCategory(category: category);
        _newsItems = articleList;
        return articleList;
      }
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
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    super.build(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: !(widget.articleType == ArticleType.AROUNDME && userProvider.user.longitude == null)
          ? FutureBuilder(
              future: loadFeed(),
              builder: (context, snapshot) => (snapshot.hasData)
                  ? RefreshIndicator(
                      onRefresh: loadFeed,
                      backgroundColor: Get.theme.primaryColor,
                      child: snapshot.data.length == 0
                          ? Center(
                              child: Text("No news available"),
                            )
                          : ListView.builder(
                              itemBuilder: (context, index) => NewsCard(
                                article: _newsItems[index],
                                articleType: widget.articleType,
                              ),
                              itemCount: _newsItems.length,
                            ),
                    )
                  : Center(
                      child: Text("Fetching latest news for you..."),
                    ),
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("You haven't saved your location yet."),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text("Tap the \""), Icon(Icons.more_vert), Text("\" icon to set it.")],
                  ),
                ],
              ),
            ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
