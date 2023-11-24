import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/BottomNavBar/icons/home_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/message_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/notification_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/search_icon.dart';
import 'package:tweaxy/components/HomePage/WebComponents/SideBar/droptemp.dart';
import 'package:tweaxy/components/HomePage/WebComponents/SideBar/post_button.dart';
import 'package:tweaxy/components/HomePage/WebComponents/SideBar/sidebar_text.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

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

  List<bool> _isHovered = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: !kIsWeb
          ? EdgeInsets.symmetric(
              horizontal: screenWidth * 0.07, vertical: screenHeight * 0.1)
          : EdgeInsets.all(0),
      child: Visibility(
        child: ListView(
          padding: EdgeInsets.only(top: 5),
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
            PostButton()
          ],
        ),
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
