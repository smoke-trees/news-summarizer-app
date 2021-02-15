
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider extends ChangeNotifier {
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>['email', 'profile'],
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> autoSignInGoogle() async {
    try {
      GoogleSignInAccount googleSignInAccount;
      googleSignInAccount = await _googleSignIn.signInSilently();
      if (googleSignInAccount == null) {
        googleSignInAccount = await _googleSignIn.signIn();
        print("[FirebaseAuthController] Not silent sign in");
      }
      final GoogleSignInAuthentication googleAuth = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCred = await _auth.signInWithCredential(credential);
      return userCred;
    } catch (e) {
      Get.snackbar("Error creating Account", e.message,
          snackPosition: SnackPosition.BOTTOM, snackStyle: SnackStyle.FLOATING);
    }
  }
}
