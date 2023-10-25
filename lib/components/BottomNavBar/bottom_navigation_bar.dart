import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:tweaxy/components/BottomNavBar/icons/home_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/message_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/notification_icon.dart';
import 'package:tweaxy/components/BottomNavBar/icons/search_icon.dart';

class BottomNaviagtion extends StatefulWidget {
  const BottomNaviagtion({super.key});

  @override
  State<BottomNaviagtion> createState() => _BottomNaviagtionState();
}

class _BottomNaviagtionState extends State<BottomNaviagtion> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      items: <BottomNavigationBarItem>[
        //home icon
        BottomNavigationBarItem(
          icon: HomeIcon(
            selectedIndex: _selectedIndex,
          ),
          label: '',
        ),
        //search icon
        BottomNavigationBarItem(
            icon: SearchIcon(
              selectedIndex: _selectedIndex,
            ),
            label: ''),
        //notification icon
        BottomNavigationBarItem(
          icon: NotificationIcon(
            selectedIndex: _selectedIndex,
          ),
          label: '',
        ),
        //message icon
        BottomNavigationBarItem(
            icon: MessageIcon(selectedIndex: _selectedIndex), label: ''),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped, // Handle item selection

      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
