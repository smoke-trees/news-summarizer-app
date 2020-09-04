import 'package:flutter/material.dart';
import 'package:news_summarizer/src/ui/pages/home_page.dart';
import 'package:news_summarizer/src/ui/pages/news_page.dart';

class BasePage extends StatefulWidget {
  static const routename = "/base";

  @override
  _BasePageState createState() => _BasePageState();
}

class _BasePageState extends State<BasePage> {
  int _currNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [HomeWidget(), NewsPage()];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'News Summarizer',
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).accentColor),
        ),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.tonality),
        //     onPressed: () {
        //       themeProvider.toggleTheme();
        //     },
        //   ),
        // ],
      ),
      body: screens[_currNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).cardColor,
        currentIndex: _currNavIndex,
        onTap: (value) {
          setState(() {
            _currNavIndex = value;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.featured_play_list),
            title: Text('News'),
          ),
        ],
      ),
    );
  }
}
