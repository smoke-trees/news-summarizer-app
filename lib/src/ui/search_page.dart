import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_summarizer/src/models/summary.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {

  final _dio = Dio(BaseOptions(baseUrl: 'https://8ed5933bec9f.ngrok.io/'));


  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    final apiProvider = Provider.of<ApiProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Search results',
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).accentColor)),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.tonality),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      body: Center(
        child: Text(apiProvider.searchTerm),
      ),
    );
  }

  Future<void> getSummary(String searchTerm) async {
    try {
      var response =
          await _dio.get('/get_result', queryParameters: {'query': searchTerm});
      return SummaryResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return SummaryResponse.withError(error.toString());
    }
  }
}
