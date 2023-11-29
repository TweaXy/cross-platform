import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/Views/signup/mobile/create_account_data_review_view.dart';
import 'package:tweaxy/views/followersAndFollowing/followers.dart';
import 'package:tweaxy/views/followersAndFollowing/following.dart';
import 'package:tweaxy/views/followersAndFollowing/web_followers_followings.dart';
import 'package:tweaxy/views/signup/mobile/authentication_view.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';
import 'package:tweaxy/views/homepage.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/views/login/login_view_page1.dart';
import 'package:tweaxy/views/signup/create_account_view.dart';
import 'package:tweaxy/views/signup/create_account_web_view.dart';
import 'package:tweaxy/views/splash_screen.dart';
import 'package:tweaxy/views/start_screen.dart';
import 'package:tweaxy/views/start_screen_web.dart';

void main() {
  // _save();
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
          bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
          brightness: brightness,
          fontFamily: 'Roboto',
          useMaterial3: false,
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
          kAuthenticationScreen: (context) => AuthenticationView(),
          kHomeScreen: (context) => HomePage(),
          kCreateAcountReviewScreen: (context) => CreateAccountDataReview(),
          kProfileScreen: (context) => ProfileScreen(),
          kFollowers: (context) => FollowersPage(),
          kFollowing: (context) => FollowingPage(),
          kwebboth: (context) => WebFollowersAndFollowings(),
        },
        initialRoute: kSplashScreen,
      ),
    );
  }
}

void _save() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', 'clpj7l5wq00033h9kml3a9vkp');
  await prefs.setString('token',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xwajdsNXdxMDAwMzNoOWttbDNhOXZrcFwiIiwiaWF0IjoxNzAxMjI4NjA2LCJleHAiOjE3MDM4MjA2MDZ9.qrToCvvaZTBWK1yn-fFlYE9zkU2ZsYwA3PiW1uVFvCo');
}
