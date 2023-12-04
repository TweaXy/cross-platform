import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/BottomNavBar/icons/home_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/message_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/notification_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/search_icon.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/components/HomePage/WebComponents/SideBar/post_button.dart';
import 'package:tweaxy/components/HomePage/WebComponents/SideBar/sidebar_text.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/services/temp_user.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({Key? key}) : super(key: key);

  @override
  _SideNavBarState createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  /// views to display
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

  final List<bool> _isHovered = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: !kIsWeb
          ? EdgeInsets.symmetric(
              horizontal: screenWidth * 0.07, vertical: screenHeight * 0.1)
          : const EdgeInsets.all(0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(top: 5),
              children: [
                ListTile(
                  leading: SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 40, // Adjust the width as needed
                    height: 40, // Adjust the height as needed
                    alignment: Alignment.center,
                  ),
                ),

                InkWell(
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                        30,
                      ),
                    ),
                    leading: HomeIcon(
                      selectedIndex: selectedIndex,
                    ),
                    title: SideBarText(
                      selectedIndex: selectedIndex,
                      curindex: 0,
                      text: 'Home',
                    ),
                    onTap: () {
                      // Navigator.pop(context);
                      _globalOnTap(0);
                    },
                  ),
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  leading: SearchIcon(
                    selectedIndex: selectedIndex,
                  ),
                  title: SideBarText(
                    curindex: 1,
                    selectedIndex: selectedIndex,
                    text: 'Explore',
                  ),
                  onTap: () {
                    // Navigator.pop(context);
                    _globalOnTap(1);
                  },
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  leading: NotificationIcon(
                    selectedIndex: selectedIndex,
                  ),
                  title: SideBarText(
                    text: 'Notifications',
                    selectedIndex: selectedIndex,
                    curindex: 2,
                  ),
                  onTap: () {
                    // Navigator.pop(context);
                    _globalOnTap(2);
                  },
                ),
                ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      30,
                    ),
                  ),
                  leading: MessageIcon(
                    selectedIndex: selectedIndex,
                  ),
                  title: SideBarText(
                    text: 'Message',
                    selectedIndex: selectedIndex,
                    curindex: 3,
                  ),
                  onTap: () {
                    // Navigator.pop(context);
                    _globalOnTap(3);
                  },
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
                            : const Color.fromARGB(255, 137, 137, 137))
                        : (selectedIndex == 4
                            ? Colors.white
                            : const Color.fromARGB(255, 176, 176, 176)),
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
                const PostButton(),
              ],
            ),
          ),
          ElevatedButton(
            style: ButtonStyle(
              padding: MaterialStateProperty.all<EdgeInsets>(
                  const EdgeInsets.all(17)),
              elevation: MaterialStateProperty.all<double>(0),
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return Colors.white;
                  }
                  return Colors.white; // Use the component's default.
                },
              ),
              side: MaterialStateProperty.all(const BorderSide(
                color: Colors.transparent,
                width: 0.0,
              )),
              splashFactory: NoSplash.splashFactory,
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45.0),
              )),
              overlayColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.hovered)) {
                    return const Color.fromARGB(
                        255, 224, 224, 224); //<-- SEE HERE
                  }
                  return Colors.white; // Defer to the widget's default.
                },
              ),
            ),
            // style: ElevatedButton.styleFrom(
            //     splashFactory: NoSplash.splashFactory,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(25),
            //     ),
            //     backgroundColor: Colors.transparent),
            onPressed: () {},

            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: UserImageForTweet(
                      image: TempUser.image,
                      userid: '',
                      text: '',
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.5),
                          child: Text(
                            TempUser.name,
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                color: Color.fromARGB(255, 13, 11, 11),
                                fontWeight: FontWeight.bold,
                                fontSize: 15),
                          ),
                        ),
                        Text(
                          maxLines: 1,
                          '@${TempUser.username}',
                          style: TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14,
                              color: Colors.grey.shade600),
                        )
                      ],
                    ),
                  ),
                  const Icon(
                    FontAwesomeIcons.ellipsis,
                    size: 15,
                    color: Color.fromARGB(255, 80, 80, 80),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: screenHeight * 0.1)
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
