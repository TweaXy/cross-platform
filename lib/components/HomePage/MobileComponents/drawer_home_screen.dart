import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tweaxy/components/HomePage/WebComponents/SideBar/sidebar_text.dart';
import 'package:tweaxy/components/HomePage/SharedComponents/user_image_for_tweet.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/services/temp_user.dart';

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

  final List<bool> _isHovered = [false, false, false, false, false];

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: UserImageForTweet(image: TempUser.image),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 4.5),
                  child: Text(
                      TempUser.name,
                    style:const TextStyle(
                        color: Color.fromARGB(255, 13, 11, 11),
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                Text(
                  '@${TempUser.username}',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                )
              ],
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.only(bottom: screenHeight * 0.1),
          //   child:
          //       ListTile(leading: UserImageForTweet(image: 'assets/girl.jpg')),
          // ),
          const Divider(height: 7),
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
            onTap: () async{
              // Navigator.pop(context);
              // _globalOnTap(4);
              await Navigator.pushNamed(context, kProfileScreen);
              setState(() {
                
              });
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
