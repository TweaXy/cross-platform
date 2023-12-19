import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAPI {
  final dio = Dio();
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

      String? token = await userCredential.user?.getIdToken();
      return token;

      while (token!.length > 0) {
        int initLength = (token!.length >= 500 ? 500 : token.length);
        print(token.substring(0, initLength));
        int? endLength = token.length;
        token = token.substring(initLength, endLength);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<dynamic> login() async {
    String token = await signInWithGoogle();
    if (token.length > 0) {
      Response response = await dio.post(
          'https://tweaxybackend.mywire.org/api/v1/auth/google/android/',
          data: {'token': token});
      SharedPreferences user = await SharedPreferences.getInstance();
      print('kk' + response.data.toString());
      print('kkkk' + response.data['data']['token'].toString());

      user.setString('username', response.data['data']['user']['username']);
      user.setString("token", response.data['data']['token']);
      user.setString("id", response.data['data']['user']['id']);

      print(response.toString());
      print(response.data['data']['token']);
      print(response.data['data']['user']['username']);
      return response.data;
    } else
      return null;
  }
}
