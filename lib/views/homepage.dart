import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/HomePage/MobileComponents/homepage_mobile.dart';
import 'package:tweaxy/components/HomePage/WebComponents/homepage_web.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/helpers/firebase_api.dart';
import 'package:tweaxy/services/send_device_token.dart';
import 'package:tweaxy/services/temp_user.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    checkNotificationTokenSent();

    _tabController = TabController(vsync: this, length: 1);

    _tabController.addListener(_handleTabSelection);
  }

  Future checkNotificationTokenSent() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Save user information
    var notificationToken = prefs.getString('notificationTokenSent');
    log('Notification Token = $notificationToken');
    var userToken = prefs.getString('token');
    if (notificationToken == null) {
      var notificationToken = await FirebaseApi.initNotifications();
      SendDeviceToken.getAllNotifications(
        userToken,
        notificationToken,
      );
      prefs.setString(
        'notificationTokenSent',
        notificationToken!,
      );
    }
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TempUser.userSetData(context);

    return Scaffold(
      backgroundColor: Theme.of(context).brightness == Brightness.light
          ? Colors.white
          : Colors.black,
      body: kIsWeb
          ? HomePageWeb(
              tabController: _tabController,
            )
          : HomePageMobile(
              tabController: _tabController,
            ),
    );
  }
}
