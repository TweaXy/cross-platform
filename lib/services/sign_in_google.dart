import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInApi {
  static const clientIdWeb =
      '150598822682-k32n8uknhd9o6vqdnr045qic68103ou1.apps.googleusercontent.com';
  static const clientIdAndroid =
      '731962970730-eogvrnvtmkq777vvd7s5gumlguqql9o2.apps.googleusercontent.com';
  static final GoogleSignIn _googleSignInMob =
      GoogleSignIn(clientId: clientIdAndroid);
  static final GoogleSignIn googleSignInWeb = GoogleSignIn(
    clientId: clientIdWeb,
  );

  static Future<GoogleSignInAccount?> loginMob() async {
    return await _googleSignInMob.signIn();
  }

  static Future<GoogleSignInAccount?> logoutMob() {
    return _googleSignInMob.signOut();
  } //this signout is for mobile but it saves your account`

  static Future<GoogleSignInAccount?> signoutMob() => _googleSignInMob
      .disconnect(); //this signout is for mobile and it deletes your account

  static Future<GoogleSignInAccount?> loginWeb() async {
    return await googleSignInWeb.signIn();
  }

  static Future<GoogleSignInAccount?> logoutWeb() => googleSignInWeb.signOut();
  static Future<GoogleSignInAccount?> signoutWeb() =>
      googleSignInWeb.disconnect();

  static Future<bool> checkIfSignedIn() async {
    if (kIsWeb) {
      return await googleSignInWeb.isSignedIn();
    }
    return await _googleSignInMob.isSignedIn();
  }

  static Future<String?> getGoogleToken() async {
    String? token;
    if (kIsWeb) {
      token = await googleSignInWeb.currentUser?.authentication
          .then((value) => value.idToken);
    } else {
      token = await _googleSignInMob.currentUser?.authentication
          .then((value) => value.idToken);
    }
    return token;
  }
}
