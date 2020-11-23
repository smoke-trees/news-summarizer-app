import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/ui/pages/get_location_page.dart';
import 'package:news_summarizer/src/ui/pages/news_page.dart';
import 'package:news_summarizer/src/ui/pages/notifs_checklist_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_onboarding_page.dart';
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
  var _blogsFeeds;
  bool _isSearchActive = false;
  bool _isBlogsSelected = false;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _getNewsFromHive();
  }

  _getNewsFromHive() async {
    var newsBox = Hive.box(NEWS_PREFS_BOX);
    _newsFeeds = newsBox.get(NEWS_PREFS);
    _blogsFeeds = newsBox.get(NEWS_BLOGS_AUTHORS);
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
                  fillColor: Get.theme.cardColor,
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

  Drawer drawerWidget() {
    return Drawer(
      child: Container(
        color: Get.theme.primaryColor,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Text(
                'News Summarizer',
                style: TextStyle(color: Get.theme.primaryColor, fontSize: 20),
              ),
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
              ),
            ),
            ListTile(
              title: Text(
                'News',
                style: TextStyle(color: Get.theme.accentColor, fontSize: 18),
              ),
              focusColor: Get.theme.accentColor,
              onTap: () {
                setState(() {
                  _isBlogsSelected = false;
                });
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Text(
                'Blogs',
                style: TextStyle(color: Get.theme.accentColor, fontSize: 18),
              ),
              focusColor: Get.theme.accentColor,
              onTap: () {
                setState(() {
                  _isBlogsSelected = true;
                });
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  AppBar _withoutSearchAppBar({Widget bottom, String titleText}) {
    return AppBar(
        centerTitle: true,
        leading: InkWell(
          child: Icon(Icons.search),
          onTap: () => setState(() {
            _isSearchActive = true;
          }),
        ),
        title: Text(
          titleText,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Get.theme.accentColor,
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
                  // Get.toNamed(PreferencesPage.routeName);
                  Get.toNamed(PreferencesOnboardingPage.routeName);
                  break;
                case "Change Location":
                  Get.toNamed(GetLocationPage.routeName);
                  break;
                case "Notification Center":
                  Get.toNamed(NotifsChecklistPage.routeName);
              }
            },
            itemBuilder: (context) {
              return {'Change Theme', 'Change News Preferences', "Change Location", "Notification Center"}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
        bottom: bottom);
  }

  BottomNavigationBar _bottomNavigationBar() {
    return BottomNavigationBar(
      backgroundColor: Get.theme.primaryColor,
      // fixedColor: Get.theme.accentColor,
      selectedItemColor: Get.theme.accentColor,
      elevation: 50,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          title: Text('News'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          title: Text('Expert Opinion'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          title: Text('Around Me'),
        ),
      ],
      currentIndex: _selectedTab,

      onTap: (index) {
        if (index == 0) {
          setState(() {
            _selectedTab = 0;
          });
        } else if (index == 1) {
          setState(() {
            _selectedTab = 1;
          });
        } else if (index == 2) {
          setState(() {
            _selectedTab = 2;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // super.build(context);
    return _selectedTab == 1
        ? DefaultTabController(
            length: _blogsFeeds.length,
            child: Scaffold(
              bottomNavigationBar: _bottomNavigationBar(),
              appBar: (!_isSearchActive)
                  ? _withoutSearchAppBar(
                      titleText: "Expert Opinion",
                      bottom: _blogsFeeds.isEmpty
                          ? PreferredSize(
                              preferredSize: Size.fromHeight(0),
                              child: SizedBox.shrink(),
                            )
                          : TabBar(
                              tabs: List.generate(
                                _blogsFeeds.length,
                                (index) {
                                  return Tab(
                                    text: (_blogsFeeds[index] as String).toUpperCase(),
                                  ); //Very bad method but eet ees what eet ees
                                },
                              ),
                              isScrollable: true,
                            ),
                    )
                  : _searchAppBar(context),
              // drawer: drawerWidget(),
              backgroundColor: Get.theme.scaffoldBackgroundColor,
              body: _blogsFeeds.isEmpty
                  ? Center(
                      child: Text("Add an expert to your preferences"),
                    )
                  : TabBarView(
                      children: List.generate(
                        _blogsFeeds.length,
                        (index) {
                          return NewsPage(
                            blogAuthor: _blogsFeeds[index],
                            isBlogAuthor: true,
                            isCustomPref: false,
                          ); //Very bad method but eet ees what eet ees
                        },
                      ),
                    ),
            ))
        : _selectedTab == 2
            ? Scaffold(
                bottomNavigationBar: _bottomNavigationBar(),
                appBar: (!_isSearchActive)
                    ? _withoutSearchAppBar(titleText: "Around Me")
                    : _searchAppBar(context),
                // drawer: drawerWidget(),
                backgroundColor: Get.theme.scaffoldBackgroundColor,
                body: NewsPage(
                  isAroundMe: true,
                ),
              )
            : DefaultTabController(
                length: _newsFeeds.length,
                child: Scaffold(
                  bottomNavigationBar: _bottomNavigationBar(),
                  // drawer: drawerWidget(),
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  appBar: (!_isSearchActive)
                      ? _withoutSearchAppBar(
                          titleText: "News",
                          bottom: TabBar(
                            tabs: List.generate(
                              _newsFeeds.length,
                              (index) {
                                return Tab(
                                  text: _newsFeeds[index]
                                      .toString()
                                      .split('.')
                                      .last
                                      .replaceAll("_", " ")
                                      .toUpperCase(),
                                );
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
                            customPref: _newsFeeds[index].toString().split('.').last.replaceAll("_", " "),
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
