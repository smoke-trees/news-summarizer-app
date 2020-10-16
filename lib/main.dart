import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/app.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/auth_provider.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(NewsFeedAdapter());
  await Hive.openBox(NEWS_PREFS_BOX);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<ApiProvider>(create: (_) => ApiProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider())
      ],
      child: App(),
    ),
  );
}
