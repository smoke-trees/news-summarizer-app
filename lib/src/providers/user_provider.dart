import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hive/hive.dart';
import 'package:news_summarizer/src/models/article.dart';
import 'package:news_summarizer/src/models/user.dart';
import 'package:news_summarizer/src/utils/article_type_enum.dart';
import 'package:news_summarizer/src/utils/constants.dart';
import 'package:news_summarizer/src/utils/hive_prefs.dart';

class UserProvider extends ChangeNotifier {
  ApiUser user;

  var userBox = Hive.box<ApiUser>(USER_BOX);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void setUserInProvider({ApiUser setUser}) {
    print("[UserProvider] Set user in provider");
    user = setUser;
    saveToHive(user: user);
    // notifyListeners();
  }

  void createUserInFirebase({ApiUser newUser}) {
    print("[UserProvider] Creating user in firebase");
    FirebaseFirestore.instance.collection('user').doc(newUser.firebaseUid).set(newUser.toJson());
  }

  ApiUser createNewUser({User newUser, String phoneNumber = ""}) {
    print("[UserProvider] Creating user in provider");
    user = ApiUser(
        photoUrl: newUser.photoURL,
        email: newUser.email,
        name: newUser.displayName,
        firebaseUid: newUser.uid,
        phoneNumber: phoneNumber);
    // createUserInFirebase(newUser: user);
    // saveToHive(user: user);
    return user;
  }

  Future<ApiUser> getUserFromFirebase({String firebaseUid}) async {
    var response = await FirebaseFirestore.instance.collection('user').doc(firebaseUid).get();
    ApiUser fireUser = ApiUser.fromJson(response.data());
    // print(fireUser.toJson(fireUser));
    return fireUser;
  }

  void configureFCM() {
    // _firebaseMessaging.configure(
    //   onMessage: (Map<String, dynamic> message) async {
    //     print("onMessage: $message");
    //     final notification = message['notification'];
    //   },
    //   onLaunch: (Map<String, dynamic> message) async {
    //     print("onLaunch: $message");
    //
    //     final notification = message['data'];
    //   },
    //   onResume: (Map<String, dynamic> message) async {
    //     print("onResume: $message");
    //   },
    // );
    // _firebaseMessaging
    //     .requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));
    //
    // ProfileHive sp = new ProfileHive();
    // _firebaseMessaging.onTokenRefresh.listen((event) {
    //   String userFCMToken = sp.getUserFCMToken();
    //   if (event != userFCMToken) {
    //     print("FCM Saved in shared_prefs");
    //     user.fcmToken = event;
    //     sp.setUserFCMToken(event);
    //     setFCMtokenInFirebase(fcmtoken: user.fcmToken);
    //   }
    // });
  }

  void setFCMtokenInFirebase({String fcmtoken}) {
    if (user.firebaseUid == null) {
      print("[UserProvider] No user in firebase, so no FCM saved");
    } else {
      FirebaseFirestore.instance.collection('user').doc(user.firebaseUid).update({'fcmToken': fcmtoken});
    }
    user.fcmToken = fcmtoken;
    notifyListeners();
  }

  void setUserLocation({Position position}) {
    if (user.firebaseUid != null) {
      FirebaseFirestore.instance
          .collection('user')
          .doc(user.firebaseUid)
          .update({'location.latitude': position.latitude, 'location.longitude': position.longitude});
      print("[UserProvider] Set user location in Firebase");
    } else {
      print("[UserProvider] No user in Firebase. Did not Set user location in Firebase");
    }

    user.latitude = position.latitude;
    user.longitude = position.longitude;
    saveToHive(user: user);
    notifyListeners();
  }

  void setNewsPreferences({List prefsList}) {
    if (user != null && user.firebaseUid != null) {
      print("[UserProvider] Set news preferences in Firebase");
      FirebaseFirestore.instance
          .collection('user')
          .doc(user.firebaseUid)
          .update({'newsPreferences': prefsList.map((e) => e.toString()).toList()});
    } else {
      print("[UserProvider] No user in Firebase. Did not Set news preferences in Firebase");
    }

    user.newsPreferences = prefsList;
    saveToHive(user: user);
    notifyListeners();
  }

  void setCustomPreferences({List prefsList}) {
    if (user.firebaseUid != null) {
      print("[UserProvider] Set custom preferences in Firebase");
      FirebaseFirestore.instance
          .collection('user')
          .doc(user.firebaseUid)
          .update({'customPreferences': prefsList.map((e) => e.toString()).toList()});
    } else {
      print("[UserProvider] No user in Firebase. Did not Set custom preferences in Firebase");
    }

    user.customPreferences = prefsList;
    saveToHive(user: user);
    notifyListeners();
  }

  void setBlogPreferences({List prefsList}) {
    if (user.firebaseUid != null) {
      print("[UserProvider] Set blog preferences in Firebase");
      FirebaseFirestore.instance
          .collection('user')
          .doc(user.firebaseUid)
          .update({'blogPreferences': prefsList.cast<String>()});
    } else {
      print("[UserProvider] No user in Firebase. Did not Set blog preferences in Firebase");
    }

    user.blogPreferences = prefsList;
    saveToHive(user: user);
    notifyListeners();
  }

  void setPubPreferences({List prefsList}) {
    if (user.firebaseUid != null) {
      print("[UserProvider] Set pub preferences in Firebase");
      FirebaseFirestore.instance
          .collection('user')
          .doc(user.firebaseUid)
          .update({'pubPreferences': prefsList.cast<String>()});
    } else {
      print("[UserProvider] No user in Firebase. Did not Set pub preferences in Firebase");
    }

    user.pubPreferences = prefsList;
    saveToHive(user: user);
    notifyListeners();
  }

  void setNotificationPrefs({List<String> prefsList}) {
    if (user.firebaseUid != null) {
      print("[UserProvider] Set notification in Firebase");
      FirebaseFirestore.instance
          .collection('user')
          .doc(user.firebaseUid)
          .update({'notifEnabledPrefs': prefsList});
    } else {
      print("[UserProvider] No user in Firebase. Did not Set notif preferences in Firebase");
    }

    user.notifEnabledPrefs = prefsList;
    saveToHive(user: user);
    notifyListeners();
  }

  void saveArticle({Article article, ArticleType articleType}) {
    String changeKey;
    switch(articleType){
      case ArticleType.NEWS:
        user.savedNewsIds.add(article.id);
        changeKey = "savedNewsIds";
        break;
      case ArticleType.CUSTOM:
        user.savedNewsIds.add(article.id);
        changeKey = "savedNewsIds";
        break;
      case ArticleType.AROUNDME:
        user.savedNewsIds.add(article.id);
        changeKey = "savedNewsIds";
        break;
      case ArticleType.PUB:
        user.savedPubIds.add(article.id);
        changeKey = "savedPubIds";
        break;
      case ArticleType.EXPERT:
        user.savedBlogsIds.add(article.id);
        changeKey = "savedBlogsIds";
        break;
    }
    // user.savedNewsIds.add(article.id);

    if (user.firebaseUid != null) {
      print("[UserProvider] Saved news in Firebase");
      FirebaseFirestore.instance
          .collection('user')
          .doc(user.firebaseUid)
          .update({changeKey: user.savedNewsIds});
    } else {
      print("[UserProvider] No user in Firebase. Did not Set save news in Firebase");
    }
    saveToHive(user: user);
    notifyListeners();
  }

  void unsaveArticle({Article article, ArticleType articleType}) {
    String changeKey;
    switch(articleType){
      case ArticleType.NEWS:
        user.savedNewsIds.remove(article.id);
        changeKey = "savedNewsIds";
        break;
      case ArticleType.CUSTOM:
        user.savedNewsIds.remove(article.id);
        changeKey = "savedNewsIds";
        break;
      case ArticleType.AROUNDME:
        user.savedNewsIds.remove(article.id);
        changeKey = "savedNewsIds";
        break;
      case ArticleType.PUB:
        user.savedPubIds.remove(article.id);
        changeKey = "savedPubIds";
        break;
      case ArticleType.EXPERT:
        user.savedBlogsIds.remove(article.id);
        changeKey = "savedBlogsIds";
        break;
    }


    if (user.firebaseUid != null) {
      print("[UserProvider] Removed saved news in Firebase");
      FirebaseFirestore.instance
          .collection('user')
          .doc(user.firebaseUid)
          .update({changeKey: user.savedNewsIds});
    } else {
      print("[UserProvider] No user in Firebase. Did not remove saved news in Firebase");
    }
    saveToHive(user: user);
    notifyListeners();
  }

  void subscribeToTopic({String topic}) {
    print("[UserProvider] Subscribing to topic $topic");
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void unsubscribeToTopic({String topic}) {
    print("[UserProvider] Unsubscribe to topic $topic");
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }

  void saveToHive({ApiUser user}) {
    print("[UserProvider] Changes in user saved to Hive");
    userBox.put("user", user);
  }

  ApiUser fetchFromHive() {
    ApiUser hiveUser = userBox.get("user");
    if (hiveUser != null) {
      print("[UserProvider] Fetched user from Hive");
      user = hiveUser;
      return user;
    } else {
      print("[UserProvider] No saved user in Hive");
      return null;
    }
  }
}
