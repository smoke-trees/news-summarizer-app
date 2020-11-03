import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/ui/pages/base_page.dart';
import 'package:news_summarizer/src/ui/pages/blogs_prefs_page.dart';
import 'package:news_summarizer/src/ui/widgets/listview_card.dart';
import 'package:news_summarizer/src/utils/constants.dart';

class ReorderPrefsPage extends StatefulWidget {
  static String routeName = "/reorder_prefs_page";

  @override
  _ReorderPrefsPageState createState() => _ReorderPrefsPageState();
}



class _ReorderPrefsPageState extends State<ReorderPrefsPage> {
  var _newsBox = Hive.box(NEWS_PREFS_BOX);
  var preferences = [];

  @override
  void initState() {
    super.initState();
    preferences = _newsBox.get(NEWS_PREFS) ?? [];
    // preferences = preferences.map((e) => e.toString()).toList();

  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(
      () {
        if (newIndex > oldIndex) {
          newIndex -= 1;
        }
        var item = preferences.removeAt(oldIndex);
        preferences.insert(newIndex, item);
      },
    );
  }

  void finishReordering() {
    _newsBox.put(NEWS_PREFS, preferences);
    Navigator.pushNamedAndRemoveUntil(
      context,
      BlogsPrefsPage.routeName,
          (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(
          'Re-order Preferences',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).accentColor,
          ),
        ),
        actions: [
          GestureDetector(
            child: Container(
              margin: EdgeInsets.only(right: 16),
              alignment: Alignment.center,
              child: Text(
                "Done",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            onTap: () => finishReordering(),
          ),
        ],
      ),
      body: Theme(
        data: ThemeData(
            canvasColor: Colors.transparent
        ),
        child: ReorderableListView(
          padding: EdgeInsets.only(left: 10, right: 10, top: 10),
          onReorder: _onReorder,

          children: List.generate(
            preferences.length,
            (index) {
              return ListViewCard(
                preferences.map((e) => e.toString()).toList(),
                index,
                Key('$index'),
              );
            },
          ),
        ),
      ),
    );
  }
}
