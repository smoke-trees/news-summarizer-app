import 'package:hive/hive.dart';

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

  @HiveField(12)
  List<String> savedNewsIds;

  @HiveField(13)
  List<String> savedBlogsIds;

  @HiveField(14)
  List<String> savedPubIds;

  @HiveField(15)
  List<String> pubPreferences;

  @HiveField(16)
  bool isUserLoggedIn;

  @HiveField(17)
  bool completedOnboarding;

  @HiveField(18)
  bool forceRelogin;

  @HiveField(19)
  Map<String, dynamic> ipifyObject;

  ApiUser({
    this.email,
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
    this.notifEnabledPrefs,
    this.savedNewsIds,
    this.pubPreferences,
    this.savedBlogsIds,
    this.savedPubIds,
    this.completedOnboarding,
    this.isUserLoggedIn,
    this.forceRelogin,
    this.ipifyObject,
  });

  factory ApiUser.fromJson(json) {
    return ApiUser(
      blogPreferences: json['blogPreferences'] == null
          ? []
          : (json['blogPreferences'] as List)?.cast<String>() ?? [],
      newsPreferences: json['newsPreferences'] == null
          ? []
          : (json['newsPreferences'] as List)?.cast<String>() ?? [],
      customPreferences: json['customPreferences'] == null
          ? []
          : (json['customPreferences'] as List)?.cast<String>() ?? [],
      pubPreferences: json['pubPreferences'] == null
          ? []
          : (json['pubPreferences'] as List)?.cast<String>() ?? [],
      name: json['name'],
      email: json['email'],
      fcmToken: json['fcmToken'],
      photoUrl: json['photoUrl'],
      firebaseUid: json['firebaseUid'],
      phoneNumber: json['phoneNumber'],
      latitude: json['location']['latitude'],
      longitude: json['location']['longitude'],
      notifEnabledPrefs: json['notifEnabledPrefs'] == null
          ? []
          : (json['notifEnabledPrefs'] as List).cast<String>() ?? [],
      savedPubIds: json['savedPubIds'] == null
          ? []
          : (json['savedPubIds'] as List)?.cast<String>() ?? [],
      savedBlogsIds: json['savedBlogsIds'] == null
          ? []
          : (json['savedBlogsIds'] as List)?.cast<String>() ?? [],
      savedNewsIds: json['savedNewsIds'] == null
          ? []
          : (json['savedNewsIds'] as List)?.cast<String>() ?? [],
      isUserLoggedIn: json['isUserLoggedIn'] ?? false,
      completedOnboarding: json['completedOnboarding'] ?? false,
      forceRelogin: json['forceRelogin'] ?? false,
      ipifyObject: json['ipifyObject'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['blogPreferences'] = blogPreferences;
    data['newsPreferences'] = newsPreferences;
    data['customPreferences'] = customPreferences ?? [];
    data['pubPreferences'] = pubPreferences ?? [];
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
    data['savedNewsIds'] = savedNewsIds ?? [];
    data['savedBlogsIds'] = savedBlogsIds ?? [];
    data['savedPubIds'] = savedPubIds ?? [];
    data['completedOnboarding'] = completedOnboarding ?? false;
    data['isUserLoggedIn'] = isUserLoggedIn ?? false;
    data['forceRelogin'] = forceRelogin ?? false;
    data['ipifyObject'] = ipifyObject;
    return data;
  }
}
