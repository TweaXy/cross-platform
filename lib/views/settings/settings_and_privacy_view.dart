import 'package:flutter/material.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/settings/update_email_components/custom_data_display.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:tweaxy/views/settings/settings_view.dart';

class SettingsAndPrivacyView extends StatelessWidget {
  const SettingsAndPrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SettingsAppBar(
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
                CustomdataDisplay(
                  lead: const Icon(AppIcon.notification),
                  title: "Notifications",
                  subtitle:
                      "Select the kinds of notifications you get about your activity,intrests and recommendations.",
                  onpress: () {},
                ),
              ],
            ),
          ),
        ));
  }
}
