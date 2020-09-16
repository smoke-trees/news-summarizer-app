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
      body: Stack(children: [
        WebView(
          initialUrl: widget.article.link,
          javascriptMode: JavascriptMode.unrestricted,
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkResponse(
              splashColor: Theme.of(context).primaryColor,
              onTap: () {
                setState(() {
                  showSummary = true;
                });
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            child: Container(
                                padding: const EdgeInsets.all(20.0),
                                child: Text(
                                  widget.article.summary,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context).accentColor),
                                ))),
                      );
                    });
              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.5,
                height: MediaQuery.of(context).size.height * 0.08,
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: Center(
                  child: Text(
                    "Summary",
                    style: TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ),
          ),
        )
        // Align(
        //   alignment: Alignment.bottomCenter,
        //   child: showSummary
        //       ? Hero(
        //           tag: "sum",
        //           child: Container(
        //             decoration: BoxDecoration(
        //                 color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10)),
        //             child: Container(
        //               padding: const EdgeInsets.all(10.0),
        //               child: Text(
        //                 widget.article.summary,
        //                 style: TextStyle(
        //                     fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).accentColor),
        //               ),
        //             ),
        //           ),
        //         )
        //       : Hero(
        //           tag: "sum",
        //           child: Container(
        //             width: MediaQuery.of(context).size.width * 0.5,
        //             height: MediaQuery.of(context).size.height * 0.1,
        //             decoration: BoxDecoration(
        //                 color: Theme.of(context).primaryColor, borderRadius: BorderRadius.circular(10)),
        //             padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        //             child: Center(
        //               child: InkResponse(
        //                 onTap: () {
        //                   setState(() {
        //                     showSummary = true;
        //                   });
        //                 },
        //                 child: Text(
        //                   "Summary",
        //                   style: TextStyle(
        //                       fontSize: 22,
        //                       fontWeight: FontWeight.bold,
        //                       color: Theme.of(context).accentColor),
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ),
        // ),
      ]),
    );
  }
}
