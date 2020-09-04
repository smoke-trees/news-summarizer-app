import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_summarizer/src/utils/html_utils.dart';
import 'package:webfeed/domain/rss_item.dart';

class NewsCard extends StatelessWidget {
  final RssItem newsItem;

  NewsCard({this.newsItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        elevation: 4,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (getImageUrl(newsItem.description) != null)
                ? CachedNetworkImage(
                    imageUrl: getImageUrl(newsItem.description),
                  )
                : Container(),
            Container(
              padding: EdgeInsets.all(16),
              width: double.infinity,
              color: Theme.of(context).cardColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsItem.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  Text('${DateFormat.yMMMMEEEEd().format(newsItem.pubDate)}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
