import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/ui/pages/news_web_view.dart';
import 'package:news_summarizer/src/utils/html_utils.dart';
import 'package:provider/provider.dart';

class NewsCard extends StatelessWidget {
  final Article article;
  final bool isBlog;

  NewsCard({this.article, this.isBlog = false});

  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Theme.of(context).cardColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (getImageUrl(article.description) != null)
                    ? CachedNetworkImage(
                        imageUrl: getImageUrl(article.description),
                        fit: BoxFit.cover,
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
                        article.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${DateFormat.yMMMMEEEEd().format(article.pubDate)}',
                        // '${article.pubDate}',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 15),
                      Divider(
                        color: Theme.of(context).accentColor,
                        thickness: 2,
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Summary",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Container(
                        child: Text(article.description),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          if (isBlog) {
            apiProvider.makeViewBlog(article: article);
          } else {
            apiProvider.makeViewNews(article: article);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsWebView(
                article: article,
                isBlog: isBlog,
              ),
            ),
          );
        },
      ),
    );
  }
}
