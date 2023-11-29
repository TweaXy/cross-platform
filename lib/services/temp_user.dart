import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/helpers/api.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempUser {
  TempUser._();
  static TempUser? _instance;
  static String email = '';
  static String username = '';
  static String name = '';
  static String image = 'uploads/default.png';
  static String baseUrl = 'http://16.171.65.142:3000/api/v1';
  // String baseUrl = 'http://localhost:3000/api/v1';
  static void setEmail({required String email}) {
    TempUser.email = email;
  }

  static void setUserName({required String username}) {
    TempUser.username = username;
  }

  static void setName({required String name}) {
    TempUser.name = name;
  }

  static void setImage({required String image}) {
    TempUser.image = image;
  }

  static void userSetData() async {
    //  print(email);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('id');
    Response res = await Api.get('$baseUrl/users/$userid');
    print('resss' + res.toString());
    if (res is String) {
    } else {
      setEmail(email: res!.data['data']['user']['email']);
      setName(name: res!.data['data']['user']['name']);
      setUserName(username: res!.data['data']['user']['username']);
      setImage(image: res!.data['data']['user']['avatar']);    }
  }
}
