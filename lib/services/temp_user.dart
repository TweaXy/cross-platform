import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/services/get_unseen_notification_count.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TempUser {
  TempUser._();
  static int notificationCount = 0;
  static TempUser? _instance;
  static String email = '';
  static String id = '';
  static String token = '';
  static String username = '';
  static String name = '';
  static String image = 'uploads/default.png';
  static String baseUrl = 'https://tweaxybackend.mywire.org/api/v1';
  // String baseUrl = 'http://localhost:3000/api/v1';
  static void setEmail({required String email}) {
    TempUser.email = email;
  }

  static void setToken({required String token}) {
    TempUser.token = token;
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

  static void setId({required String id}) {
    TempUser.id = id;
  }

  static void userSetData() async {
    //  print(email);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userid = prefs.getString('id');
    String? token = prefs.getString('token');
    setToken(token: token!);
    dynamic result = await Api.getwithToken(
        token: token,
        url: 'https://tweaxybackend.mywire.org/api/v1/users/$userid');
    if (result is String) {
    } else if (result is Response) {
      // int notifica =
          // await GetUnseenNotificationCount.getUnseenNotificationCount(token);
      Response res = result;
      setEmail(email: res.data['data']['user']['email']);
      setName(name: res.data['data']['user']['name']);
      setUserName(username: res.data['data']['user']['username']);
      setImage(image: res.data['data']['user']['avatar']);
      setId(id: res.data['data']['user']['id']);
      // TempUser.notificationCount = notifica;
    }
  }
}
