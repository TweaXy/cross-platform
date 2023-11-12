import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/views/signup/mobile/authentication_view.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';
import 'package:tweaxy/services/get_user_by_id.dart';
import 'package:tweaxy/views/homepage.dart';
import 'package:tweaxy/views/profile/edit_profile_screen.dart';

import 'package:tweaxy/constants.dart';
import 'package:tweaxy/views/login/login_view_page1.dart';
import 'package:tweaxy/views/signup/mobile/create_account_view.dart';
import 'package:tweaxy/views/signup/web/create_account_web_view.dart';
import 'package:tweaxy/views/splash_screen.dart';
import 'package:tweaxy/views/start_screen.dart';
import 'package:tweaxy/views/start_screen_web.dart';

void main() {
  runApp(const TweaXy());
}

class TweaXy extends StatelessWidget {
  const TweaXy({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return OKToast(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          brightness: brightness,
          fontFamily: 'Roboto',
          scaffoldBackgroundColor: isDarkMode ? Colors.black : Colors.white,
          dialogBackgroundColor: isDarkMode ? Colors.black : Colors.white,
        ),
        routes: {
          kSplashScreen: (context) => const SplashScreen(),
          kStartScreen: (context) => const StartScreen(),
          kWebStartScreen: (context) => const WebStartScreen(),
          kLogin1Screen: (context) => const LoginViewPage1(),
          kCreateAcountScreen: (context) => const CreateAccountView(),
          kCreateAcountWebScreen: (context) => const CreateAccountWebView(),
          kAuthenticationScreen: (context) => const AuthenticationView(),
          kHomeScreen: (context) => HomePage(),
        },
        initialRoute: kSplashScreen,
      ),
    );
  }
}
