import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:news_summarizer/src/utils/shared_prefs.dart';

class UserProvider extends ChangeNotifier {
  String fcmToken;
  String firebaseUid;
  List<String> preferences;

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void createUserInFirebase({User user}) {
    print("[UserProvider] Creating user in firebase");
    FirebaseFirestore.instance.collection('user').doc(user.uid).set({
      'profileImage': user.photoURL,
      'displayName': user.displayName,
    });
    firebaseUid = user.uid;
  }

  void configureFCM() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        final notification = message['notification'];
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");

        final notification = message['data'];
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging
        .requestNotificationPermissions(const IosNotificationSettings(sound: true, badge: true, alert: true));

    _firebaseMessaging.onTokenRefresh.listen((event) async {
      String userFCMToken = await SharedPrefs.getUserFCMToken();
      if (event != userFCMToken) {
        print("FCM Saved in shared_prefs");
        fcmToken = event;
        SharedPrefs.setUserFCMToken(event);
        setFCMtokenInFirebase(fcmtoken: fcmToken);
      }
    });
  }

  void setFCMtokenInFirebase({String fcmtoken}) {
    FirebaseFirestore.instance.collection('user').doc(firebaseUid).update({'fcmToken': fcmtoken});
    fcmToken = fcmtoken;
  }

  Future<String> getFCMtokenFromFirebase() async {
    var data = await FirebaseFirestore.instance.collection('user').doc(firebaseUid).get();
    fcmToken = data.data()['fcmToken'];
    return fcmToken;
  }

  void subscribeToTopic({String topic}){
    print("[UserProvider] Subscribing to topic $topic");
    _firebaseMessaging.subscribeToTopic(topic);
  }

  void unsubscribeToTopic({String topic}){
    print("[UserProvider] Unsubscribe to topic $topic");
    _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
