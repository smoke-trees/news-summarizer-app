import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/ui/pages/news_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_page.dart';
import 'package:news_summarizer/src/ui/pages/search_page.dart';
import 'package:news_summarizer/src/ui/widgets/theme_dialog.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:provider/provider.dart';

class NewsContainerPage extends StatefulWidget {
  @override
  _NewsContainerPageState createState() => _NewsContainerPageState();
}

class _NewsContainerPageState extends State<NewsContainerPage>
    with AutomaticKeepAliveClientMixin<NewsContainerPage> {
  var _newsFeeds;
  bool _isSearchActive = false;

  @override
  void initState() {
    super.initState();
    _getNewsFromHive();
  }

  _getNewsFromHive() async {
    var newsBox = Hive.box(NEWS_PREFS_BOX);
    _newsFeeds = newsBox.get(NEWS_PREFS);

    // print(_newsFeeds);
  }

  Future<void> _showThemeDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return ThemeDialog();
      },
    );
  }

  Widget _searchAppBar(BuildContext context) {
    final apiProvider = Provider.of<ApiProvider>(context);

    return AppBar(
      title: Row(
        children: [
          Icon(Icons.search),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8),
              height: 45,
              child: TextField(
                textInputAction: TextInputAction.search,
                onSubmitted: (value) {
                  apiProvider.setSearchTerm(value);
                  setState(() {
                    _isSearchActive = false;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SearchPage()),
                  );
                },
                autofocus: true,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.bottom,
                decoration: InputDecoration(
                  hintText: "Search for any news topic!",
                  filled: true,
                  fillColor: Theme.of(context).cardColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(
                      width: 0,
                      style: BorderStyle.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          InkWell(
            child: Text(
              "Cancel",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            onTap: () => setState(() {
              _isSearchActive = false;
            }),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DefaultTabController(
      length: _newsFeeds.length,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: (!_isSearchActive)
            ? AppBar(
                centerTitle: true,
                leading: InkWell(
                  child: Icon(Icons.search),
                  onTap: () => setState(() {
                    _isSearchActive = true;
                  }),
                ),
                title: Text(
                  'News',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).accentColor,
                  ),
                ),
                actions: [
                  PopupMenuButton(
                    onSelected: (value) async {
                      switch (value) {
                        case 'Change Theme':
                          _showThemeDialog(context);
                          break;
                        case 'Change News Preferences':
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PreferencesPage(),
                            ),
                          );
                          break;
                      }
                    },
                    itemBuilder: (context) {
                      return {'Change Theme', 'Change News Preferences'}.map((String choice) {
                        return PopupMenuItem<String>(
                          value: choice,
                          child: Text(choice),
                        );
                      }).toList();
                    },
                  ),
                ],
                bottom: TabBar(
                  tabs: List.generate(
                    _newsFeeds.length,
                    (index) {
                      if (_newsFeeds[index].runtimeType == String) {
                        return Tab(
                          text: (_newsFeeds[index] as String).toUpperCase(),
                        ); //Very bad method but eet ees what eet ees
                      } else {
                        return Tab(
                          text: _newsFeeds[index].toString().split('.').last.replaceAll("_", " "),
                        );
                      }
                    },
                  ),
                  isScrollable: true,
                ),
              )
            : _searchAppBar(context),
        body: TabBarView(
          children: List.generate(
            _newsFeeds.length,
            (index) {
              if (_newsFeeds[index].runtimeType == String) {
                return NewsPage(
                  customPref: _newsFeeds[index],
                  isCustomPref: true,
                ); //Very bad method but eet ees what eet ees
              } else {
                return NewsPage(
                  newsFeed: _newsFeeds[index],
                  isCustomPref: false,
                );
              }
            },
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
