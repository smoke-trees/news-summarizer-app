import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/dynamic_link_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/news_web_view.dart';
import 'package:news_summarizer/src/utils/html_utils.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

class NewsCard extends StatefulWidget {
  final Article article;
  final bool isBlog;

  NewsCard({this.article, this.isBlog = false});

  @override
  _NewsCardState createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  bool isSaved = false;

  @override
  void initState() {
    super.initState();
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.user.savedNewsIds == null) {
      userProvider.user.savedNewsIds = [];
    }
    if (userProvider.user.savedNewsIds.contains(widget.article.id)) {
      isSaved = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    ApiProvider apiProvider = Provider.of<ApiProvider>(context, listen: false);
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    DynamicLinkProvider dynamicLinkProvider = Provider.of<DynamicLinkProvider>(context, listen: false);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          color: Get.theme.cardColor,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (getImageUrl(widget.article.description) != null)
                    ? CachedNetworkImage(
                        imageUrl: getImageUrl(widget.article.description),
                        fit: BoxFit.fill,
                      )
                    : Container(),
                Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  color: Get.theme.cardColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.article.title,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${DateFormat.yMMMMEEEEd().format(widget.article.pubDate)}',
                            // '${widget.article.pubDate}',
                            style: TextStyle(fontSize: 12),
                          ),
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                    icon: Icon(isSaved ? Icons.bookmark : Icons.bookmark_border),
                                    onPressed: () {
                                      setState(() {
                                        isSaved = !isSaved;
                                      });
                                      if (isSaved) {
                                        userProvider.saveNews(article: widget.article);
                                      } else {
                                        userProvider.unsaveNews(article: widget.article);
                                      }
                                    }),
                                IconButton(
                                    icon: Icon(Icons.share),
                                    onPressed: () async {
                                      String url =
                                          await dynamicLinkProvider.getDynamicLink(article: widget.article);

                                      Share.share('${widget.article.title} \n $url',
                                          subject: 'News From Terran Tidings');
                                    })
                              ],
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: 15),
                      Divider(
                        color: Get.theme.accentColor,
                        thickness: 2,
                      ),
                      SizedBox(height: 10),
                      // Text(
                      //   "Summary",
                      //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      // ),
                      SizedBox(height: 10),
                      Container(
                        child: Text(
                            widget.isBlog ? widget.article.description ?? "" : widget.article.summary ?? ""),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          if (widget.isBlog) {
            apiProvider.makeViewBlog(article: widget.article);
          } else {
            apiProvider.makeViewNews(article: widget.article);
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewsWebView(
                article: widget.article,
                isBlog: widget.isBlog,
              ),
            ),
          );
        },
      ),
    );
  }
}
