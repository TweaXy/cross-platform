import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/helpers/firebase_api.dart';
import 'package:tweaxy/services/send_device_token.dart';
import 'package:tweaxy/services/temp_user.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

String? token;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkLogin();
    Timer(const Duration(seconds: 2), () {
      if (token == null) {
        kIsWeb
            ? Navigator.pushReplacementNamed(context, kWebStartScreen)
            : Navigator.pushReplacementNamed(context, kStartScreen);
      } else {
        Navigator.pushReplacementNamed(context, kHomeScreen);
      }
    });
  }

  Future checkLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = null;
    // Save user information
    var retrivedtoken = prefs.getString("token");
    token = retrivedtoken;
  }

  Future checkNotificationTokenSent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = null;
    // Save user information
    var notificationToken = prefs.getString('notificationTokenSent');
    var retrivedtoken = prefs.getString("token");
    print('Token = $notificationToken');
    token = retrivedtoken;
    TempUser.token = token ?? '';
    if (notificationToken == null) {
      var notificationToken = await FirebaseApi.initNotifications();
      SendDeviceToken.getAllNotifications(
        token,
        notificationToken,
      );
      prefs.setString(
        'notificationTokenSent',
        notificationToken!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SvgPicture.asset(
          width: 100,
          height: 100,
          'assets/images/logo.svg',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
