import 'package:flutter/material.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final Article article;

  NewsWebView({this.article});

  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  bool showSummary = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'News',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
        ),
      ),
      body: WebView(
        initialUrl: widget.article.link,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
