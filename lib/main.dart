import 'package:flutter/material.dart';
import 'package:news_summarizer/src/app.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<ApiProvider>(create: (_) => ApiProvider())
      ],
      child: App(),
    ),
  );
}
