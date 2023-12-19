import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/settings/update_email_components/custom_data_display.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:tweaxy/shared/keys/settings_keys.dart';
import 'package:tweaxy/views/settings/mutes_and_blocks/settings_privacy_safety_screen.dart';
// import 'package:tweaxy/views/settings/notification_settings/notification_settings_view.dart';
import 'package:tweaxy/views/settings/settings_view.dart';

class SettingsAndPrivacyView extends StatelessWidget {
  SettingsAndPrivacyView({super.key});

  bool notiifcationEnable = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SettingsAppBar(
          key: ValueKey(SettingsKeys.backIcon),
          title: "Settings",
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .02),
                  child: CustomdataDisplay(
                    key: const ValueKey(SettingsKeys.yourAccount),
                    lead: const Icon(AppIcon.profile),
                    title: "Your account",
                    subtitle:
                        "See information about your account, and make changes to your them.",
                    onpress: () {
                      Navigator.push(
                          context,
                          CustomPageRoute(
                              direction: AxisDirection.left,
                              child: const SettingsView()));
                    },
                  ),
                ),
                // CustomdataDisplay(
                //   key: const ValueKey(SettingsKeys.notifications),
                //   lead: const Icon(AppIcon.notification),
                //   title: "Notifications",
                //   subtitle:
                //       "Select the kinds of notifications you get about your activity,intrests and recommendations.",
                //   onpress: () {
                //     Navigator.push(
                //         context,
                //         CustomPageRoute(
                //             direction: AxisDirection.left,
                //             child: const NoticicationSettingsView()));
                //   },
                // ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .02),
                  child: CustomdataDisplay(
                    lead: const Icon(Icons.verified_user_outlined),
                    title: 'Privacy and safety',
                    subtitle:
                        'Manage what information you see and share on TweaXy',
                    onpress: () {
                      Navigator.push(
                          context,
                          CustomPageRoute(
                              direction: AxisDirection.left,
                              child: const SettingsPrivacySafetyScreen()));
                    },
                  ),
                ),
                SwitchListTile(
                  title: const Text('Notification Enable'),
                  value: notiifcationEnable,
                  onChanged: (bool value) {

                  },
                ),
              ],
            ),
          ),
        ));
  }
}
