import 'package:google_sign_in/google_sign_in.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';

class GoogleSignINApi {
  static final clintId =
      '700717640171-iuhebo2m8jvqf8msk87qt30fr2hrp4co.apps.googleusercontent.com';
  static final _googleSignInMob = GoogleSignIn(clientId: clintId);
  static late GoogleSignInAuthentication googleSignInAuthentication;
  static Future<GoogleSignInAccount?> login() async {
    try {
      final GoogleSignInAccount? user = await _googleSignInMob.signIn();
      if (user == null) {
        CustomWebToast(message: "Failed to sign in");
      } else {
        print("Token ID: ${user.authHeaders}");
      }
      return user;
    } catch (error) {
      print("Error during sign-in: $error");
      CustomWebToast(message: "Error during sign-in");
      return null;
    }
  }
// static Future<void> getToken() async {
//     try {
//       GoogleSignInAccount? user = await _googleSignIn.signIn();

//       googleSignInAuthentication = await user!.authentication;
//     } catch (error) {
//       print('error in getting the token\n\n\n');
//       print('error');
//     }
//   }
  static Future<String?> getGoogleToken() async {
    String? token;

    token = await _googleSignInMob.currentUser?.authentication
        .then((value) => value.idToken);
    return token;
  }
}
