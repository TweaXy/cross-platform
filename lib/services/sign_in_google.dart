import 'package:google_sign_in/google_sign_in.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';

class GoogleSignINApi {
  // static final clintId =
  //     '700717640171-sqacemimlo7ia3bft4btrr46b4736hdf.apps.googleusercontent.com';
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() async {
    try {
      final GoogleSignInAccount? user = await _googleSignIn.signIn();
      if (user == null) {
        CustomWebToast(message: "Failed to sign in");
      } else {
        // Successful sign-in, you can access user.idToken here
        print("Token ID: ${user.authHeaders}");
      }
      return user;
    } catch (error) {
      print("Error during sign-in: $error");
      CustomWebToast(message: "Error during sign-in");
      return null;
    }
  }

  static Future<GoogleSignInAccount?> logout() => _googleSignIn.disconnect();
}
