import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/utils/article_type_enum.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsWebView extends StatefulWidget {
  final Article article;
  final ArticleType articleType;

  NewsWebView({this.article, this.articleType});

  @override
  _NewsWebViewState createState() => _NewsWebViewState();
}

class _NewsWebViewState extends State<NewsWebView> {
  bool showSummary = false;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        title: Text(
          widget.articleType == ArticleType.EXPERT
              ? "Expert Opinion"
              : widget.articleType == ArticleType.PUB
                  ? "Publication"
                  : 'News',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Get.theme.accentColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          WebView(
            initialUrl: widget.article.link,
            javascriptMode: JavascriptMode.unrestricted,
            // onPageFinished: (finish) {
            //   print("finish");
            //   print(finish);
            //   setState(() {
            //     isLoading = false;
            //   });
            // },
          ),
          // isLoading
          //     ? Center(
          //         child: CircularProgressIndicator(),
          //       )
          //     : SizedBox.shrink(),
        ],
      ),
    );
  }
}
