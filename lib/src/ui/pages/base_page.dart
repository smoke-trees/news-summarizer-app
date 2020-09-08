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
  int _currNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> screens = [NewsContainerPage(), HomeWidget(), SettingPage()];

    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
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
            icon: Icon(Icons.featured_play_list),
            title: Text('News'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            title: Text('Search'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
