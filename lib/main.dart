import 'package:flutter/material.dart';
import 'package:news_summarizer/src/app.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider<ThemeProvider>(
    create: (_) => ThemeProvider(),
    child: App(),
  ));
}
