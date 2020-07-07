import 'package:flutter/material.dart';
import 'package:news_summarizer/src/models/summary.dart';
import 'package:news_summarizer/src/ui/widgets/news_item.dart';

class NewsList extends StatelessWidget {
  final List<SummaryResponse> news;

  NewsList(this.news);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: news.length,
      itemBuilder: (BuildContext context, int index) {
        var item = news[index];
        return NewsItem(item.headline, item.summary);
      },
    );
  }
}