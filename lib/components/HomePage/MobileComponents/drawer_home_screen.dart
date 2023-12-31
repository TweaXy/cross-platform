import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/HomePage/MobileComponents/custom_drawer_list_tile.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_cubit.dart';
import 'package:tweaxy/cubits/update_username_cubit/update_username_states.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/views/settings/settings_and_privacy_view.dart';
import 'package:tweaxy/shared/keys/home_page_keys.dart';
import 'package:tweaxy/views/profile/profile_screen.dart';

class CustomDrawer extends StatelessWidget {
  /// Views to display
  // List<String> items = [
  //   'Home',
  //   'Explore',
  //   'Notifications',
  //   'Message',
  //   'Profile'
  // ];

  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03, vertical: screenHeight * 0.05),
      child: ListView(
        padding: const EdgeInsets.only(top: 5),
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, bottom: screenHeight * 0.07),
            child: GestureDetector(
              key: const ValueKey(HomePageKeys.userInfoInDrawerClick),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      id: TempUser.id,
                      text: '',
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: UserImageForTweet(
                      image: TempUser.image,
                      userid: TempUser.id,
                      text: '',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.5),
                    child: Text(
                      TempUser.name,
                      style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          color: Color.fromARGB(255, 13, 11, 11),
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                  BlocBuilder<UpdateUsernameCubit, UpdateUsernameStates>(
                    builder: (context, state) {
                      return Text(
                        maxLines: 1,
                        '@${TempUser.username}',
                        style: TextStyle(
                            overflow: TextOverflow.ellipsis,
                            fontSize: 16,
                            color: Colors.grey.shade600),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
          const Divider(height: 7),
          CustomDrawerListTile(
            key: const ValueKey(HomePageKeys.profileNavigatorInDrawer),
            icon: AppIcon.profile,
            title: 'Profile',
            onTap: () {
              Navigator.pushNamed(context, kProfileScreen);
            },
          ),
          SizedBox(
            height: screenHeight * 0.4,
          ),
          const Divider(height: 7),
          CustomDrawerListTile(
            key: const ValueKey(HomePageKeys.settingsAndPrivacy),
            icon: AppIcon.settings,
            title: 'Settings and privacy',
            onTap: () {
              Navigator.push(
                  context,
                  CustomPageRoute(
                      direction: AxisDirection.left,
                      child:  const SettingsAndPrivacyView()));
            },
          ),
        ],
      ),
    );
  }
}
