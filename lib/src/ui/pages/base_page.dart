import 'package:flutter/material.dart';
import 'package:news_summarizer/src/ui/pages/home_page.dart';
import 'package:news_summarizer/src/ui/pages/news_container_page.dart';
import 'package:news_summarizer/src/ui/pages/settings_page.dart';

class BasePage extends StatefulWidget {
  static const routename = "/base";

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: NewsContainerPage(),
    );
  }
}
