import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSingInApi {
  signInWithGoogle() async {
    try {
      const List<String> scopes = <String>[
        'email',
        'openid',
        'https://www.googleapis.com/auth/contacts.readonly',
      ];
      GoogleSignInAccount? googleUser = await GoogleSignIn(
        scopes: scopes,
      ).signIn();
      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print("start");
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User? user = FirebaseAuth.instance.currentUser;
      print(user);
      String? token = await userCredential.user?.getIdToken();

      print("end");
      print(await googleAuth?.idToken);
      print("==================");
      print(await userCredential.user?.getIdToken());
      print("==================");
      print(await userCredential.user?.getIdTokenResult());
      print("==================");
      print(await userCredential.user?.displayName);
    } catch (e) {
      print(e);
    }
  }
}
