import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/models/summary.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/ui/widgets/news_list.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);

    return Scaffold(
      backgroundColor: Get.theme.backgroundColor,
      appBar: AppBar(
        centerTitle: false,
        title: Text('Search results',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Get.theme.accentColor)),
      ),
      body: Center(
        child: FutureBuilder<List<Article>>(
            future: apiProvider.getArticlesFromSearch(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Article>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Get.theme.backgroundColor,
                    ),
                  );
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Get.theme.backgroundColor,
                    ),
                  );
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Get.theme.backgroundColor,
                    ),
                  );
                case ConnectionState.done:
                  if (snapshot.hasError)
                    return Text('Error: ${snapshot.error.toString()}');
                  return NewsList(snapshot.data);
                // You can reach your snapshot.data['url'] in here
              }
              return null;
            }),
      ),
    );
  }
}
