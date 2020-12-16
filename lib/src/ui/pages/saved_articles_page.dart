import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/widgets/news_card.dart';
import 'package:provider/provider.dart';

class SavedArticlesPage extends StatefulWidget {
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
    ApiProvider apiProvider = Provider.of<ApiProvider>(context, listen: false);
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      return apiProvider.getManyArticlesByIds(ids: userProvider.user.savedNewsIds);
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
    return FutureBuilder(
        future: loadFeed(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: loadFeed,
              backgroundColor: Get.theme.primaryColor,
              child: snapshot.data.length == 0
                  ? Center(
                child: Text("Save news to see them here"),
              )
                  : ListView.builder(
                itemBuilder: (context, index) =>
                    NewsCard(
                      isBlog: false,
                      article: snapshot.data[index],
                    ),
                itemCount: snapshot.data.length,
              ),
            );
          } else {
            print(snapshot.error);
            return Center(
              child: Text("Fetching your saved news for you..."),
            );
          }
        }
    );
  }
}
