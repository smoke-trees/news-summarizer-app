import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/ui/pages/auth_page.dart';
import 'package:news_summarizer/src/ui/pages/blogs_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/control_center.dart';
import 'package:news_summarizer/src/ui/pages/get_location_page.dart';
import 'package:news_summarizer/src/ui/pages/news_page.dart';
import 'package:news_summarizer/src/ui/pages/notifs_checklist_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_onboarding_page.dart';
import 'package:news_summarizer/src/ui/pages/preferences_page.dart';
import 'package:news_summarizer/src/ui/pages/pub_page.dart';
import 'package:news_summarizer/src/ui/pages/pub_prefs_page.dart';
import 'package:news_summarizer/src/ui/pages/saved_articles_page.dart';
import 'package:news_summarizer/src/ui/pages/search_page.dart';
import 'package:news_summarizer/src/ui/widgets/theme_dialog.dart';
import 'package:news_summarizer/src/utils/article_type_enum.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:provider/provider.dart';

class NewsContainerPage extends StatefulWidget {
  @override
  _NewsContainerPageState createState() => _NewsContainerPageState();
}

class _NewsContainerPageState extends State<NewsContainerPage>
    with AutomaticKeepAliveClientMixin<NewsContainerPage> {
  List<String> _newsFeeds;
  List<String> _blogsFeeds;
  List<String> _pubFeeds;
  bool _isSearchActive = false;

  int selectedMenuItem = 0;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
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
//TODO: Put these into different files
//TODO: Add recommended channel
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

  void _onDrawerSelect(int index) {
    if (selectedMenuItem != index) {
      setState(() {
        // _isAuthSelected = false;
        selectedMenuItem = index;
      });
      Get.back();
    }
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
                'Terran Tidings',
                style: TextStyle(color: Get.theme.primaryColor, fontSize: 20),
              ),
              decoration: BoxDecoration(
                color: Get.theme.accentColor,
              ),
            ),
            ListTile(
              title: Text(
                'Home',
                style: TextStyle(color: Get.theme.accentColor, fontSize: 18),
              ),
              focusColor: Get.theme.accentColor,
              onTap: () => _onDrawerSelect(0),
            ),
            ListTile(
              title: Text(
                'Login',
                style: TextStyle(color: Get.theme.accentColor, fontSize: 18),
              ),
              focusColor: Get.theme.accentColor,
              onTap: () => _onDrawerSelect(1),
            ),
            ListTile(
              title: Text(
                'Saved Articles',
                style: TextStyle(color: Get.theme.accentColor, fontSize: 18),
              ),
              focusColor: Get.theme.accentColor,
              onTap: () => _onDrawerSelect(2),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _withoutSearchAppBar({Widget bottom, String titleText}) {
    return AppBar(
        centerTitle: true,
        // leading: InkWell(
        //   child: Icon(Icons.search),
        //   onTap: () => setState(() {
        //     _isSearchActive = true;
        //   }),
        // ),
        title: Text(
          titleText,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Get.theme.accentColor,
          ),
        ),
        actions: [
          InkWell(
            child: Icon(Icons.search),
            onTap: () => setState(() {
              _isSearchActive = true;
            }),
          ),
          PopupMenuButton(
            onSelected: (value) async {
              switch (value) {
                case 'Change Theme':
                  _showThemeDialog(context);
                  break;
                case 'Control Center':
                  Get.toNamed(ControlCenterPage.routeName);
                  // Get.toNamed(PreferencesPage.routeName);
                  // Get.toNamed(PreferencesOnboardingPage.routeName);
                  break;
                case "Change Location":
                  Get.toNamed(GetLocationPage.routeName);
                  break;
                case "Notification Center":
                  Get.toNamed(NotifsChecklistPage.routeName);
              }
            },
            itemBuilder: (context) {
              return {
                'Change Theme',
                'Control Center',
                "Change Location",
                "Notification Center"
              }.map((String choice) {
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
      type: BottomNavigationBarType.fixed,
      backgroundColor: Get.theme.primaryColor,
      // fixedColor: Get.theme.accentColor,
      selectedItemColor: Get.theme.accentColor,
      // unselectedItemColor: Get.theme.accentColor,
      elevation: 50,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Expert Opinion',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded),
          label: 'Publications',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.location_on),
          label: 'Around Me',
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
        } else if (index == 3) {
          setState(() {
            _selectedTab = 3;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    _newsFeeds = userProvider.user.newsPreferences ?? [];
    _blogsFeeds = userProvider.user.blogPreferences ?? [];
    _pubFeeds = userProvider.user.pubPreferences ?? [];

    if (selectedMenuItem == 1)
      return Scaffold(
          drawer: drawerWidget(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Terran Tidings',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.accentColor),
            ),
          ),
          body: AuthPage(
            firstLogin: false,
          ));
    else if (selectedMenuItem == 2)
      return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: drawerWidget(),
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Saved Articles',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Get.theme.accentColor),
            ),
            bottom: TabBar(
              tabs: [
                Tab(
                  text: "News",
                ),
                Tab(
                  text: "Expert Opinion",
                ),
                Tab(
                  text: "Publication",
                ),
              ],
              isScrollable: true,
            ),
          ),
          body: TabBarView(
            children: [
              SavedArticlesPage(
                articleType: ArticleType.NEWS,
              ),
              SavedArticlesPage(
                articleType: ArticleType.EXPERT,
              ),
              SavedArticlesPage(
                articleType: ArticleType.PUB,
              )
            ],
          ),
        ),
      );
    else if (selectedMenuItem == 0)
      return _selectedTab == 1
          ? DefaultTabController(
              length: _blogsFeeds.length,
              child: Scaffold(
                drawer: drawerWidget(),
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
                                      text: _blogsFeeds[index].toUpperCase(),
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Add an expert to your channels"),
                            SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.toNamed(BlogsPrefsPage.routeName);
                              },
                              child: Text(
                                "Add Expert Channels",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: themeProvider.isDarkMode
                                      ? Get.theme.accentColor
                                      : Get.theme.primaryColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    : TabBarView(
                        children: List.generate(
                          _blogsFeeds.length,
                          (index) {
                            return NewsPage(
                              blogAuthor: _blogsFeeds[index],
                              articleType: ArticleType.EXPERT,
                            ); //Very bad method but eet ees what eet ees
                          },
                        ),
                      ),
              ))
          : _selectedTab == 3
              ? Scaffold(
                  drawer: drawerWidget(),
                  bottomNavigationBar: _bottomNavigationBar(),
                  appBar: (!_isSearchActive)
                      ? _withoutSearchAppBar(titleText: "Around Me")
                      : _searchAppBar(context),
                  // drawer: drawerWidget(),
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  body: NewsPage(
                    articleType: ArticleType.AROUNDME,
                  ),
                )
              : _selectedTab == 2
                  ? DefaultTabController(
                      length: _pubFeeds.length,
                      child: Scaffold(
                        drawer: drawerWidget(),
                        bottomNavigationBar: _bottomNavigationBar(),
                        // drawer: drawerWidget(),
                        backgroundColor: Get.theme.scaffoldBackgroundColor,
                        appBar: (!_isSearchActive)
                            ? _withoutSearchAppBar(
                                titleText: "Publications",
                                bottom: _pubFeeds.isEmpty
                                    ? PreferredSize(
                                        preferredSize: Size.fromHeight(0),
                                        child: SizedBox.shrink(),
                                      )
                                    : TabBar(
                                        tabs: List.generate(
                                          _pubFeeds.length,
                                          (index) {
                                            return Tab(
                                              text: _pubFeeds[index]
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
                        body: _pubFeeds.isEmpty
                            ? Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Add a publication to your channels"),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Get.toNamed(
                                            PublicationPrefsPage.routeName);
                                      },
                                      child: Text(
                                        "Add Publications",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold,
                                          color: themeProvider.isDarkMode
                                              ? Get.theme.accentColor
                                              : Get.theme.primaryColor,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : TabBarView(
                                children: List.generate(
                                  _pubFeeds.length,
                                  (index) {
                                    return PublicationPage(
                                      source: _pubFeeds[index],
                                    );
                                  },
                                ),
                              ),
                      ),
                    )
                  : DefaultTabController(
                      length: _newsFeeds.length,
                      child: Scaffold(
                        drawer: drawerWidget(),
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
                              if (_newsFeeds[index].contains("NewsFeed.")) {
                                return NewsPage(
                                  newsFeed: _newsFeeds[index],
                                  articleType: ArticleType.NEWS,
                                );
                              } else {
                                return NewsPage(
                                  customPref: _newsFeeds[index],
                                  articleType: ArticleType.CUSTOM,
                                ); //
                              } // Very bad method but eet ees what eet ees
                            },
                          ),
                        ),
                      ),
                    );
  }

  @override
  bool get wantKeepAlive => true;
}
