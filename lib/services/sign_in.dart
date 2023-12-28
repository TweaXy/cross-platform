import 'package:dio/dio.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInServices {
  SignInServices._();
  static SignInServices? _instance;
  static String email = '';
  // http://16.171.65.142:3000/api/v1/docs/
  static String token = ''; //code sent to email
  // String baseURL = 'http://localhost:3000/api/v1';
  static void setEmail({required String email}) {
    SignInServices.email = email;
  }

  static void setToken({required String token}) {
    SignInServices.token = token;
  }

  static dynamic forgetPassword() async {
    //  print(email);
    var res = await Api.post(
      body: {'UUID': email},
      url: '${baseURL}auth/forgetPassword',
    );
    //   print('signin' + res.toString());
    if (res is String) {
      return res;
    } else {
      return "success";
    }
  }

  static dynamic resetPassword(String password) async {
    var res = await Api.post(
      url: '${baseURL}auth/resetPassword/$email/$token',
      body: {"password": password},
    );
    // print();
    print('reset$res');
    if (res is String) {
      return res;
    } else {
      print('token${res.data['data']['token']}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString("token", res.data['data']['token'].toString());
      prefs.setString("id", res.data['data']['userId'].toString());

      return "success";
    }
  }

  static dynamic checkResetToken() async {
    var res = await Api.get(
      '${baseURL}auth/checkResetToken/$email/$token',
    );
    // print(email);
    // print(token);
    // print(res);
    // print('reset' + res.toString());
    if (res is String) {
      return res;
    } else {
      return "success";
    }
  }

  static Future<String> signInGithub() async {
    String url = Uri.encodeFull(
        'http://ec2-16-171-65-142.eu-north-1.compute.amazonaws.com:3000/api/v1/auth/github/callback');
    if (await canLaunch(url)) {
      await launch(url, forceWebView: true);
      Response res = await Api.get(
        'http://ec2-16-171-65-142.eu-north-1.compute.amazonaws.com:3000/api/v1/auth/github/callback',
      );
      // print('reset' + res.data);
    } else {
      //    print('couldn\'t launch');
    }
    return "h";
  }
}
