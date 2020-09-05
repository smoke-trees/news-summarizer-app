import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/app.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
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
