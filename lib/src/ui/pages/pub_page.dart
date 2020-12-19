import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/widgets/news_card.dart';
import 'package:news_summarizer/src/utils/article_type_enum.dart';
import 'package:provider/provider.dart';

class PublicationPage extends StatefulWidget {
  final String source;

  PublicationPage({this.source});

  @override
  _PublicationPageState createState() => _PublicationPageState();
}

class _PublicationPageState extends State<PublicationPage> {
  List<Article> shownNews = [];

  @override
  void initState() {
    super.initState();
  }

  Future<List<Article>> loadFeed() async {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context, listen: false);

    try {
      return apiProvider.getArticlesFromPub(source: widget.source);
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
                      child: Text("No publication articles available."),
                    )
                  : ListView.builder(
                      itemBuilder: (context, index) => NewsCard(
                        article: snapshot.data[index],
                        articleType: ArticleType.PUB,
                      ),
                      itemCount: snapshot.data.length,
                    ),
            );
          } else if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text("Fetching your saved publications for you..."),
            );
          } else {
            return Center(
              child: Text("Fetching your saved publications for you..."),
            );
          }
        });
  }
}
