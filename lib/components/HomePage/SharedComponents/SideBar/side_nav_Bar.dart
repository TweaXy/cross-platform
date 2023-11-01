import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/BottomNavBar/icons/home_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/message_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/notification_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/search_icon.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/SideBar/droptemp.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/SideBar/post_button.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/SideBar/settings_drop_down.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/SideBar/settings_drop_down.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/SideBar/sidebar_text.dart';

class SideNavBar extends StatefulWidget {
  const SideNavBar({Key? key}) : super(key: key);

  @override
  _SideNavBarState createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
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
    return ListView(
      padding: EdgeInsets.only(top: 5),
      children: [
        ListTile(
          leading: Icon(
            FontAwesomeIcons.xTwitter,
            size: screenWidth * 0.02,
          ),
        ),
        // InkWell(
        //   customBorder:
        //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        //   onTap: () {
        //     setState(() {
        //       hoveredIndex = 0;
        //     });
        //   },
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.start,
        //     children: [
        //       HomeIcon(
        //         selectedIndex: selectedIndex,
        //       ),
        //       SideBarText(
        //         selectedIndex: selectedIndex,
        //         curindex: 0,
        //         text: 'Home',
        //       ),
        //     ],
        //   ),
        // ),
        InkWell(
          // onTap: () {
          //   setState(() {
          //     _isHovered[0] = !_isHovered[0];
          //   });
          // },
          // customBorder:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          // // borderRadius: BorderRadius.circular(30),
          // hoverColor: _isHovered[0] ? Colors.grey : Colors.transparent,
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
              setState(() {
                selectedIndex = 0;
              });
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
            setState(() {
              selectedIndex = 1;
            });
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
            setState(() {
              selectedIndex = 2;
            });
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
            setState(() {
              selectedIndex = 3;
            });
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
            color: Colors.black,
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
        SettingsAndSupport(),
        PostButton()
      ],
    );
  }
}
