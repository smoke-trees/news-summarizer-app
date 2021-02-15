import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/app.dart';
import 'package:news_summarizer/src/models/user.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:flutter/foundation.dart' show kDebugMode;

///Hive command:
///flutter packages pub run build_runner build --delete-conflicting-outputs
///build command: flutter build apk --dart-define=envType=dev
///Launcher icon command: flutter pub run flutter_launcher_icons:main
///flutter build web --dart-define=envType=dev

Future<void> initializations() async {
  WidgetsFlutterBinding.ensureInitialized();

  final appDocumentDir = await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);

  Hive.registerAdapter(ApiUserAdapter());
  await Hive.openBox(NEWS_PREFS_BOX);
  await Hive.openBox<ApiUser>(USER_BOX);
  await Hive.openBox(PROFILE_BOX);
  await Firebase.initializeApp();
  const runtimeEnv = String.fromEnvironment('envType');
  print("RUNTIME TYPE = $runtimeEnv");
  if (runtimeEnv == "dev") {
    BASE_URL = "https://news.terrantidings.com/";
  } else if (runtimeEnv == "prod") {
    BASE_URL = "https://news.smoketrees.in/";
  }
  if (kDebugMode) {
    // Force disable Crashlytics collection while doing every day development.
    // Temporarily toggle this to true if you want to test crash reporting in your app.
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
  } else {
    // Handle Crashlytics enabled status when not in Debug,
    // e.g. allow your users to opt-in to crash reporting.
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }
}

void main() async {
  await initializations();
  runApp(App());
}
