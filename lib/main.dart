import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/app.dart';
import 'package:news_summarizer/src/models/user.dart';
import 'package:news_summarizer/src/providers/api_provider.dart';
import 'package:news_summarizer/src/providers/auth_provider.dart';
import 'package:news_summarizer/src/providers/theme_provider.dart';
import 'package:news_summarizer/src/providers/user_provider.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:provider/provider.dart';


///Hive command:
///flutter packages pub run build_runner build --delete-conflicting-outputs
///
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(NewsFeedAdapter());
  Hive.registerAdapter(ApiUserAdapter());
  await Hive.openBox(NEWS_PREFS_BOX);
  await Hive.openBox<ApiUser>(USER_BOX);
  await Hive.openBox(PROFILE_BOX);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(create: (_) => ThemeProvider()),
        ChangeNotifierProvider<ApiProvider>(create: (_) => ApiProvider()),
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),
        ChangeNotifierProvider<UserProvider>(create: (_) => UserProvider()),
      ],
      child: App(),
    ),
  );
}
