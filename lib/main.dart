import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/cubits/block_user_cubit/block_user_cubit.dart';
import 'package:tweaxy/cubits/get_conversations_cubit/get_conversations_cubit.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/cubits/updata/updata_cubit.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_cubit.dart';
import 'package:tweaxy/firebase_options.dart';
import 'package:tweaxy/views/notifications/notification_screen.dart';
import 'package:tweaxy/views/settings/mutes_and_blocks/mute_and_blocks_screen.dart';
import 'package:tweaxy/views/settings/mutes_and_blocks/muted_users_screen.dart';
import 'package:tweaxy/views/settings/mutes_and_blocks/settings_privacy_safety_screen.dart';
import 'package:tweaxy/views/settings/settings_view.dart';
import 'package:tweaxy/views/settings/settings_and_privacy_view.dart';
import 'package:tweaxy/views/settings/update_password_view.dart';
import 'package:tweaxy/views/followersAndFollowing/likers_in_tweet.dart';
import 'package:tweaxy/cubits/Tweets/tweet_cubit.dart';
import 'package:tweaxy/views/search_users/search_users.dart';
import 'package:tweaxy/views/signup/mobile/create_account_data_review_view.dart';
import 'package:tweaxy/views/settings/update_email/accout_info.dart';
import 'package:tweaxy/cubits/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:tweaxy/views/followersAndFollowing/followers.dart';
import 'package:tweaxy/views/followersAndFollowing/following.dart';
import 'package:tweaxy/views/signup/mobile/authentication_view.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';
import 'package:tweaxy/views/homepage.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/views/login/login_view_page1.dart';
import 'package:tweaxy/views/signup/mobile/create_account_view.dart';
import 'package:tweaxy/views/signup/web/create_account_web_view.dart';

import 'package:tweaxy/views/splash_screen.dart';
import 'package:tweaxy/views/start_screen.dart';
import 'package:tweaxy/views/start_screen_web.dart';

void _clear() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}

void main() async {
  // _save();
  // _clear();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const TweaXy());
}

class TweaXy extends StatelessWidget {
  const TweaXy({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return OKToast(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TweetsUpdateCubit(),
          ),
          BlocProvider(
            create: (context) => BlockUserCubit(),
          ),
          BlocProvider(
            create: (context) => UpdateAllCubit(),
          ),
          BlocProvider(
            create: (context) => EditProfileCubit(),
          ),
          BlocProvider(
            create: (context) => UpdateUsernameCubit(),
          ),
          BlocProvider(
            create: (context) => GetConversationsCubit(),
          ),
           BlocProvider(
            create: (context) => SidebarCubit(),
          ),
        ],
        child: MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            bottomSheetTheme:
                const BottomSheetThemeData(backgroundColor: Colors.white),
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
            kHomeScreen: (context) => const HomePage(),
            kNotificationScreen: (context) => const NotificationScreen(),
            kCreateAcountReviewScreen: (context) =>
                const CreateAccountDataReview(),
            kProfileScreen: (context) => const ProfileScreen(
                  id: '',
                  text: '',
                ),
            kSearchScreen: (context) => SearchScreen(),
            kFollowers: (context) => FollowersPage(username: ''),
    
            kFollowing: (context) =>
                FollowingPage(username: 'karim.elsayed401_67616122'),
            kLikersInTweets: (context) =>
                LikersInTweet(id: 'sfr1ztrbdopvclujg0boys62a'),
            kAccountinfo: (context) => const AccountIfoView(),
            kSettingsAndPrivacy: (context) =>  const SettingsAndPrivacyView(),
            kSettings: (context) => const SettingsView(),
            kPrivacySafetySettings: (context) =>
                const SettingsPrivacySafetyScreen(),
            kMutesBlocksScreen: (context) => const MuteAndBlockScreen(),
            kMutedUsersScreen: (context) => const MutedUsersScreen(),
            // kLikersInProfile: (context) => const ProfileLikes(),
            kUpdatePassword: (context) => const UpdatePasswordView(),
            // kSearchTweets: (context) => SearchTweets(
            //       username: "Angel_Herzog",
            //     ),
          },
          initialRoute: kSplashScreen,
        ),
      ),
    );
  }
}

class UpdateEmailView {
  const UpdateEmailView();
}

void _save() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setString('id', 'clpj7l5wq00033h9kml3a9vkp');
  await prefs.setString('token',
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xwajdsNXdxMDAwMzNoOWttbDNhOXZrcFwiIiwiaWF0IjoxNzAxMjI4NjA2LCJleHAiOjE3MDM4MjA2MDZ9.qrToCvvaZTBWK1yn-fFlYE9zkU2ZsYwA3PiW1uVFvCo');
}
