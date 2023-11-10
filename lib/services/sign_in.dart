import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/helpers/api.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class SignInServices {
  SignInServices._();
  static SignInServices? _instance;
  static String email = '';
  // http://16.171.65.142:3000/api/v1/docs/
  static String token = ''; //code sent to email
  static String baseUrl = kIsWeb
      ? 'http://16.171.65.142:3000/api/v1'
      : 'http://16.171.65.142:3000/api/v1';
  // String baseUrl = 'http://localhost:3000/api/v1';
  static void setEmail({required String email}) {
    SignInServices.email = email;
  }

  static void setToken({required String token}) {
    SignInServices.token = token;
  }

  static dynamic forgetPassword() async {
    print(email);
    var res = await Api.post(
      body: {'UUID': email},
      url: '$baseUrl/auth/forgetPassword',
    );
    print('signin' + res.toString());
    if (res is String)
      return res;
    else
      return "success";
  }

  static dynamic resetPassword(String password) async {
    var res = await Api.post(
      url: '$baseUrl/auth/resetPassword/$email/$token',
      body: {"password": password},
    );
    print('reset' + res.toString());
    if (res is String)
      return res;
    else
      return "success";
  }

  static Future<String> signInGithub() async {
    String _url = Uri.encodeFull(
        'http://ec2-16-171-65-142.eu-north-1.compute.amazonaws.com:3000/api/v1/auth/github/callback');
    if (await canLaunch(_url)) {
      await launch(_url, forceWebView: true);
      Response res = await Api.get(
        'http://ec2-16-171-65-142.eu-north-1.compute.amazonaws.com:3000/api/v1/auth/github/callback',
      );
      print('reset' + res.data);
    } else {
      print('couldn\'t launch');
    }
    return "h";
  }
// static Future<void> _handleDeepLink() async {
//     String initialLink;
//     try {
//       initialLink = await getInitialLink();
//       // Process the returned data from the deep link
//       // Example: handleReturnedData(initialLink);
//     } catch (e) {
//       print(e.toString());
//     }
//   }

  // Add your logic to handle the returned data
  // void handleReturnedData(String data) {
  //   // Your implementation here
  // }
// }

// Future<UserCredential> signInWithGoogle() async {
//   // Trigger the authentication flow
//   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

//   // Obtain the auth details from the request
//   final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

//   // Create a new credential
//   final credential = GoogleAuthProvider.credential(
//     accessToken: googleAuth?.accessToken,
//     idToken: googleAuth?.idToken,
//   );

//   // Once signed in, return the UserCredential
//   return await FirebaseAuth.instance.signInWithCredential(credential);
// }
}
