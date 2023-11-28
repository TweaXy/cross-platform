import 'package:google_sign_in/google_sign_in.dart';

Future<String?> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: '150598822682',
    scopes: ['email'],
  );

  try {
    final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
    print(googleUser);
    if (googleUser == null) return null; // User canceled the sign-in

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    return googleAuth.idToken; // Return the Google token
  } catch (error) {
    print('Error signing in with Google: $error');
    return null;
  }
}
