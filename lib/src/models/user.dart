import 'package:hive/hive.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class ApiUser extends HiveObject {
  @HiveField(0)
  List<String> blogPreferences;

  @HiveField(1)
  List newsPreferences;

  @HiveField(2)
  List<String> customPreferences;

  @HiveField(3)
  String name;

  @HiveField(4)
  String email;

  @HiveField(5)
  String fcmToken;

  @HiveField(6)
  String photoUrl;

  @HiveField(7)
  String firebaseUid;

  @HiveField(8)
  String phoneNumber;

  @HiveField(9)
  double latitude;

  @HiveField(10)
  double longitude;

  @HiveField(11)
  List<String> notifEnabledPrefs;

  ApiUser(
      {this.email,
      this.name,
      this.blogPreferences,
      this.customPreferences,
      this.newsPreferences,
      this.fcmToken,
      this.photoUrl,
      this.firebaseUid,
      this.phoneNumber,
      this.latitude,
      this.longitude,
      this.notifEnabledPrefs});

  factory ApiUser.fromJson(json) {
    return ApiUser(
        blogPreferences: json['blogPreferences'],
        newsPreferences: json['newsPreferences'],
        customPreferences: json['customPreferences'],
        name: json['name'],
        email: json['email'],
        fcmToken: json['fcmToken'],
        photoUrl: json['photoUrl'],
        firebaseUid: json['firebaseUid'],
        phoneNumber: json['phoneNumber'],
        latitude: json['location']['latitude'],
        longitude: json['location']['longitude'],
        notifEnabledPrefs: json['notifEnabledPrefs'] ?? []);
  }

  Map<String, dynamic> toJson(ApiUser user) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blogPreferences'] = user.blogPreferences;
    data['newsPreferences'] = user.newsPreferences;
    data['customPreferences'] = user.customPreferences;
    data['name'] = user.name;
    data['email'] = user.email;
    data['fcmToken'] = user.fcmToken;
    data['photoUrl'] = user.photoUrl;
    data['firebaseUid'] = user.firebaseUid;
    data['phoneNumber'] = user.phoneNumber;
    data['location'] = Map<String, double>();
    data['location']['latitude'] = user.latitude;
    data['location']['longitude'] = user.longitude;
    data['notifEnabledPrefs'] = user.notifEnabledPrefs ?? [];
    return data;
  }
}
