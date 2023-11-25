import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

String? email;

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      if (email == null) {
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
    email = null;
    // Save user information
    var retrivedemail = prefs.getString("email");
    email = retrivedemail;
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
