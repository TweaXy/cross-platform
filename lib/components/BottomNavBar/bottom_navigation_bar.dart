import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:icon_decoration/icon_decoration.dart';
import 'package:tweaxy/components/BottomNavBar/home_icon.dart';
import 'package:tweaxy/components/BottomNavBar/notification_icon.dart';

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
          icon: IconButton(
              onPressed: () => _onItemTapped(0),
              icon:HomeIcon(selectedIndex: _selectedIndex,)),
          label: '',
        ),
        //search icon
        BottomNavigationBarItem(
            icon: IconButton(
                onPressed: () => _onItemTapped(1),
                icon: DecoratedIcon(
                  icon: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                    color: _selectedIndex == 1
                        ? Colors.black
                        : Color.fromARGB(255, 137, 137, 137),
                  ),
                  decoration: IconDecoration(
                      border: IconBorder(width: _selectedIndex == 1 ? 2 : 1)),
                )),
            label: ''),
        //notification icon
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => _onItemTapped(2),
            icon: NotificationIcon(
              iconColor: _selectedIndex == 2
                  ? Colors.black
                  : Color.fromARGB(255, 93, 93, 93),
              borderWidth: _selectedIndex == 2 ? 2 : 1,
            ),
          ),
          label: '',
        ),
        //message icon
        BottomNavigationBarItem(
          icon: IconButton(
            onPressed: () => _onItemTapped(3),
            icon: DecoratedIcon(
              icon: Icon(
                FontAwesomeIcons.envelope,
                color: _selectedIndex == 3
                    ? Colors.black
                    : Color.fromARGB(255, 93, 93, 93),
              ),
              decoration: IconDecoration(
                  border: IconBorder(width: _selectedIndex == 3 ? 2 : 1)),
            ),
          ),
          label: '',
        ),
      ],
      currentIndex: _selectedIndex,
      onTap: _onItemTapped, // Handle item selection

      showSelectedLabels: false,
      showUnselectedLabels: false,
    );
  }
}
