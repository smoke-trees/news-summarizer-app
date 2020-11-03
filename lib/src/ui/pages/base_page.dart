import 'package:flutter/material.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/news_container_page.dart';
import 'package:provider/provider.dart';

class BasePage extends StatefulWidget {
  static const routename = "/base";

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.configureFCM();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: NewsContainerPage(),
    );
  }
}
