import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final Article article;
  final bool isBlog;

  NewsWebView({this.article, this.isBlog = false});

  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  bool showSummary = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.isBlog ? "Expert Opinion" : 'News',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Get.theme.accentColor),
        ),
      ),
      body: WebView(
        initialUrl: widget.article.link,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
