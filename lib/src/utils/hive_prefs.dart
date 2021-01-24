import 'package:hive/hive.dart';
import 'constants.dart';

class ProfileHive {
  var _profileBox = Hive.box(PROFILE_BOX);

  bool getIsUserLoggedIn() {
    bool isLoggedIn = _profileBox.get('isLoggedIn') ?? false;
    print("[Hive] Received user logged in $isLoggedIn");
    return isLoggedIn;
  }

  void setIsUserLoggedIn(bool isLoggedIn) {
    print("[Hive] Set user logged in to $isLoggedIn");
    _profileBox.put('isLoggedIn', isLoggedIn);
  }

  bool getIsDarkMode() {
    bool isDarkMode = _profileBox.get('isDarkMode') ?? false;
    print("[Hive] Received isDarkMode $isDarkMode");
    return isDarkMode;
  }

  void setIsDarkMode(bool isDarkMode) {
    print("[Hive] Set isDarkMode to $isDarkMode");
    _profileBox.put('isDarkMode', isDarkMode);
  }

  String getUserFCMToken() {
    String fcmToken = _profileBox.get('fcmToken') ?? null;
    print("[Hive] Received fcmToken $fcmToken");
    return fcmToken;
  }

  void setUserFCMToken(String token) {
    print("[Hive] Set fcmToken to $token");
    _profileBox.put('fcmToken', token);
  }
}
