import 'package:flutter/material.dart';
import 'package:tweaxy/Views/settings/account_info_web_view.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';

class SettingsAdndPoicityWeb extends StatefulWidget {
  const SettingsAdndPoicityWeb({
    super.key,
  });

  @override
  State<SettingsAdndPoicityWeb> createState() => _SettingsAdndPoicityWebState();
}

class _SettingsAdndPoicityWebState extends State<SettingsAdndPoicityWeb> {
  int selectedItem = 0;
  int item = 0;
  @override
  void initState() {
    super.initState();
    selectedItem = 1;
    item = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 0.5,
          ),
          right: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const ListTile(
            title: Text("Settings",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 0.4,
                )),
          ),
          ListTile(
            shape: Border(
              right: BorderSide(
                color: selectedItem == 1 ? Colors.blue : Colors.white,
                width: 2.0,
              ),
            ),
            onTap: () {
              _globalOnTap(1);
            },
            title: const Text("Your account"),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          ),
          ListTile(
            shape: Border(
              right: BorderSide(
                color: selectedItem == 2 ? Colors.blue : Colors.white,
                width: 2.0,
              ),
            ),
            onTap: () {
              _globalOnTap(2);
            },
            title: const Text("Notification"),
            trailing: const Icon(Icons.arrow_forward_ios_outlined),
          )
        ],
      ),
    );
  }

  void _globalOnTap(index) {
    setState(() {
      selectedItem = index;
    });
  }
}
