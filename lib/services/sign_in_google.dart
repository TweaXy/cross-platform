import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignINApi {
  // static final clintId =
  //     '700717640171-sqacemimlo7ia3bft4btrr46b4736hdf.apps.googleusercontent.com';
  static final _googleSignIn = GoogleSignIn();
  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
  static Future<GoogleSignInAccount?> logout() => _googleSignIn.disconnect();
}
