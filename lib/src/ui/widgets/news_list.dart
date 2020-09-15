import 'package:flutter/material.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/models/summary.dart';
import 'package:news_summarizer/src/ui/widgets/news_card.dart';
import 'package:news_summarizer/src/ui/widgets/news_item.dart';

class NewsList extends StatelessWidget {
  final List<Article> articles;

  NewsList(this.articles);

  @override
  Widget build(BuildContext context) {
    return articles.length == 0
        ? Center(
            child: Text("No search results"),
          )
        : ListView.builder(
            itemCount: articles.length,
            itemBuilder: (BuildContext context, int index) {
              return NewsCard(
                article: articles[index],
              );
            },
          );
  }
}
