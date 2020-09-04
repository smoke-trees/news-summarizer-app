import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/ui/pages/auth_page.dart';
import 'package:news_summarizer/src/ui/pages/base_page.dart';
import 'package:news_summarizer/src/ui/pages/home_page.dart';
import 'package:news_summarizer/src/utils/shared_prefs.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return GetMaterialApp(
      title: 'News Summarizer',
      theme: themeProvider.theme,
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: SharedPrefs.getIsUserLoggedIn(),
        builder: (context, snapshot) =>
            (snapshot.connectionState == ConnectionState.done)
                ? (snapshot.data == false || snapshot.data == null)
                    ? AuthPage()
                    : BasePage()
                : Container(),
      ),
      routes: {
        HomeWidget.routename: (context) => HomeWidget(),
        BasePage.routename: (context) => BasePage(),
      },
    );
  }
}
