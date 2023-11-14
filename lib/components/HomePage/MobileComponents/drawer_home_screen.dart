import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/BottomNavBar/icons/home_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/message_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/notification_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/search_icon.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/SideBar/droptemp.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/SideBar/post_button.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/SideBar/sidebar_text.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  /// Views to display
  List<String> items = [
    'Home',
    'Explore',
    'Notifications',
    'Message',
    'Profile'
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;
  int hoveredIndex = -1;

  List<bool> _isHovered = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: screenWidth * 0.03, vertical: screenHeight * 0.05),
      child: ListView(
        padding: EdgeInsets.only(top: 5),
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.1),
            child:
                ListTile(leading: UserImageForTweet(image: 'assets/girl.jpg')),
          ),

          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                30,
              ),
            ),
            leading: Icon(
              FontAwesomeIcons.user,
              size: 27,
              color: Theme.of(context).brightness == Brightness.light
                  ? (selectedIndex == 4
                      ? Colors.black
                      : Color.fromARGB(255, 137, 137, 137))
                  : (selectedIndex == 4
                      ? Colors.white
                      : Color.fromARGB(255, 176, 176, 176)),
            ),
            title: SideBarText(
              text: 'Profile',
              selectedIndex: selectedIndex,
              curindex: 4,
            ),
            onTap: () {
              // Navigator.pop(context);
              _globalOnTap(4);
            },
          ),
          // SettingsAndSupport(),
        ],
      ),
    );
  }

  void _globalOnTap(index) {
    setState(() {
      selectedIndex = index;
    });
    BlocProvider.of<SidebarCubit>(context).toggleMenu(selectedIndex);
  }
}
