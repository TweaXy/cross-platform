import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kSplashScreen = 'splash_screen';
const kStartScreen = 'start_screen';
const kLogin1Screen = 'login1_screen';
const kLogin2Screen = 'login2_screen';
const kForgetPass1Screen = 'forget1_screen';
const kForgetPass2Screen = 'forget2_screen';
const kForgetPass3Screen = 'forget3_screen';
const kCreateAcountScreen = 'create_account_screen';
const kCreateAcountWebScreen = 'create_account_web_screen';
const kCreateAcountReviewScreen = 'create_account_review_screen';
const kAuthenticationScreen = 'authentication_screen';
const kNotRobotScreen = 'not_robot_screen';
const kSignupCodeVerificationScreen = 'signup_code_verification_screen';
const kAddPassScreen = 'add_pass_screen';
const kSearchScreen = 'search_screen';
const kAddUsernameScreen = 'add_username_screen';
const kAddProfilePicScreen = 'add_profile_pic_screen';
const kWebStartScreen = 'web_start_screen';
const kProfileScreen = 'profile_screen';
const kHomeScreen = 'home_page';
const kAddTweetScreen = 'add_tweet_screen';
const kFollowers = 'followers';
const kFollowing = 'following';
const kPrivacySafetySettings = 'privacy_safety_settings';
const kMutesBlocksScreen = 'mutes_and_blocks_screen';
const kMutedUsersScreen = 'muted_users_screen';
const kSettingsAndPrivacy = 'settings';
const kUpdatePassword = 'update_password';
const kNotificationScreen = 'notification_screen';
const kwebboth = 'bothFollowingsAndFollowers';
const kLikersInTweets = 'bothFollowingsAndFollowers';
const kGreyHoveredColor = Color.fromARGB(50, 158, 158, 158);
const baseURL = 'https://tweaxybackend.mywire.org/api/v1/';
// const baseURl = 'https://eacd-196-153-2-220.ngrok.io/';
const basePhotosURL = 'https://tweaxybackend.mywire.org/api/v1/images/';
const kDefaultBannerPhoto = 'https://www.schemecolor.com/wallpaper?i=4334&og';
const kDefaultAvatarPhoto =
    '${basePhotosURL}b631858bdaafa77258b9ed2f7c689bdb.png';
const kLikersInProfile = "likers screen";
const kSearchTweets = "search tweets screen";
const kDirectMessage = "direct_message";
const kDirectMessageWeb = "direct_message_web";
Future<List<String>> loadPrefs() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  var id = prefs.getString('id');
  var token = prefs.getString('token');
  // print('id = $id');
  // print('token = $token');
  return [id!, token!];
}

final navigatorKey = GlobalKey<NavigatorState>();
const kSettings = 'settings_view';
const kAccountinfo = "account_info_view";
