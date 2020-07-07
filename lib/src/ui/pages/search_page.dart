import 'package:flutter/material.dart';
import 'package:news_summarizer/src/models/summary.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/ui/widgets/news_list.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
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
        child: FutureBuilder<List<SummaryResponse>>(
            future: apiProvider.getSummary(apiProvider.searchTerm),
            builder: (BuildContext context,
                AsyncSnapshot<List<SummaryResponse>> snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).backgroundColor,
                    ),
                  );
                case ConnectionState.active:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).backgroundColor,
                    ),
                  );
                case ConnectionState.waiting:
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).backgroundColor,
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
