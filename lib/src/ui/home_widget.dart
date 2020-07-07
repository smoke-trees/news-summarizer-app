import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/ui/search_page.dart';
import 'package:provider/provider.dart';

class HomeWidget extends StatelessWidget {
  Route _createSearchRoute() => PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SearchPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) =>
          FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ));

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => SearchPage())
          );
        },
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('News Summarizer',
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 25.0, left: 24.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Search term',
                  hintText: 'What do you want to search for?',
                  border: OutlineInputBorder(),
                  icon: Icon(Icons.search)),
            ),
          )
        ],
      ),
    );
  }
}
