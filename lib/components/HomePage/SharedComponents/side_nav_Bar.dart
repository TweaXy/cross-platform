import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:side_navigation/side_navigation.dart';
import 'package:tweaxy/components/BottomNavBar/icons/home_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/message_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/notification_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/search_icon.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/sidebar_text.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({Key? key}) : super(key: key);

  @override
  _SideNavBarState createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  /// Views to display
  List<Widget> views = const [
    Center(
      child: Text('Dashboard'),
    ),
    Center(
      child: Text('Account'),
    ),
    Center(
      child: Text('Settings'),
    ),
  ];

  /// The currently selected index of the bar
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ListView(
      // Important: Remove any padding from the ListView.
      padding: EdgeInsets.only(top: 5),
      children: [
        ListTile(
          leading: Icon(
            FontAwesomeIcons.xTwitter,
            size: screenWidth * 0.02,
          ),
        ),
        ListTile(
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
            setState(() {
              selectedIndex = 0;
            });
          },
        ),
        ListTile(
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
            setState(() {
              selectedIndex = 1;
            });
          },
        ),
        ListTile(
          leading: NotificationIcon(
            selectedIndex: selectedIndex,
          ),
          title: SideBarText(
            text: 'Notification',
            selectedIndex: selectedIndex,
            curindex: 2,
          ),
          onTap: () {
            // Navigator.pop(context);
            setState(() {
              selectedIndex = 2;
            });
          },
        ),
        ListTile(
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
            setState(() {
              selectedIndex = 3;
            });
          },
        ),
        ListTile(
          leading: IconButton(
            onPressed: () {
              //swipe left
            },
            icon: Icon(
              FontAwesomeIcons.user,
              size: 25,
              color: Colors.black,
            ),
          ),
          title: SideBarText(
            text: 'Profile',
            selectedIndex: selectedIndex,
            curindex: 4,
          ),
          onTap: () {
            // Navigator.pop(context);
            setState(() {
              selectedIndex = 4;
            });
          },
        ),
      ],
    );
  }
}
