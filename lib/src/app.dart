import 'package:flutter/material.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/ui/pages/auth_page.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return MaterialApp(
      title: 'News Summarizer',
      theme: themeProvider.theme,
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}
