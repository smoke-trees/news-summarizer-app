import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/widgets/news_card.dart';
import 'package:news_summarizer/src/utils/article_type_enum.dart';
import 'package:provider/provider.dart';

class SavedArticlesPage extends StatefulWidget {
  ArticleType articleType;

  SavedArticlesPage({this.articleType});

  @override
  _SavedArticlesPageState createState() => _SavedArticlesPageState();
}

class _SavedArticlesPageState extends State<SavedArticlesPage> {
  List<Article> shownNews = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Article>> loadFeed() async {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context);
    UserProvider userProvider = Provider.of<UserProvider>(context);

    try {
      if (widget.articleType == ArticleType.NEWS) {
        if (userProvider.user.savedNewsIds == null || userProvider.user.savedNewsIds.isEmpty) {
          return [];
        }
        return apiProvider.getManyArticlesByIds(ids: userProvider.user.savedNewsIds)??[];
      } else if (widget.articleType == ArticleType.EXPERT) {
        if (userProvider.user.savedBlogsIds == null || userProvider.user.savedBlogsIds.isEmpty) {
          return [];
        }
        return apiProvider.getManyBlogsByIds(ids: userProvider.user.savedBlogsIds)??[];
      } else if (widget.articleType == ArticleType.PUB) {
        if (userProvider.user.savedPubIds == null || userProvider.user.savedPubIds.isEmpty) {
          return [];
        }
        return apiProvider.getManyPubByIds(ids: userProvider.user.savedPubIds)??[];
      }
    } on SocketException {
      Get.snackbar(
        "Error",
        "No Internet!",
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e, tr) {
      print(tr);
      print(e);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadFeed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: loadFeed,
              backgroundColor: Get.theme.primaryColor,
              child: snapshot.data.length == 0
                  ? Center(
                      child: Text(widget.articleType == ArticleType.EXPERT
                          ? "Save expert opinions to see them here"
                          : widget.articleType == ArticleType.PUB
                              ? "Save publication articles to see them here"
                              : "Save news to see them here"),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) => NewsCard(
                        article: snapshot.data[index],
                        articleType: widget.articleType,
                      ),
                      itemCount: snapshot.data.length,
                    ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("Fetching your saved news for you..."),
            );
          } else {
            return Center(
              child: Text("Fetching your saved news for you..."),
            );
          }
        });
  }
}
