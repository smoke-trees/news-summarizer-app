import 'package:hive/hive.dart';
import 'package:news_summarizer/src/utils/news_feed_list.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class ApiUser extends HiveObject {
  @HiveField(0)
  List<String> blogPreferences;

  @HiveField(1)
  List<String> newsPreferences;

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
        blogPreferences: (json['blogPreferences'] as List).cast<String>() ?? [],
        newsPreferences: (json['newsPreferences'] as List).cast<String>() ?? [],
        customPreferences: (json['customPreferences'] as List).cast<String>() ?? [],
        name: json['name'],
        email: json['email'],
        fcmToken: json['fcmToken'],
        photoUrl: json['photoUrl'],
        firebaseUid: json['firebaseUid'],
        phoneNumber: json['phoneNumber'],
        latitude: json['location']['latitude'],
        longitude: json['location']['longitude'],
        notifEnabledPrefs: (json['notifEnabledPrefs'] as List).cast<String>() ?? []);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blogPreferences'] = blogPreferences;
    data['newsPreferences'] = newsPreferences;
    data['customPreferences'] = customPreferences;
    data['name'] = name;
    data['email'] = email;
    data['fcmToken'] = fcmToken;
    data['photoUrl'] = photoUrl;
    data['firebaseUid'] = firebaseUid;
    data['phoneNumber'] = phoneNumber;
    data['location'] = Map<String, double>();
    data['location']['latitude'] = latitude;
    data['location']['longitude'] = longitude;
    data['notifEnabledPrefs'] = notifEnabledPrefs ?? [];
    return data;
  }
}
