import 'package:flutter/material.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/settings/custom_settings_list_tile.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:tweaxy/services/temp_user.dart';

class SettingsAndPrivacyView extends StatelessWidget {
  const SettingsAndPrivacyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: SettingsAppBar(
          title: "Settings",
          username: '@${TempUser.username}',
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            children: [
              CustomSettingsListTile(
                icon: AppIcon.profile,
                title: "Your account",
                subtitle:
                    "See information about your account, and make changes to your them.",
                onTap: () {},
              ),
              CustomSettingsListTile(
                icon: AppIcon.notification,
                title: "Notifications",
                subtitle:
                    "Select the kinds of notifications you get about your activity,intrests and recommendations.",
                onTap: () {},
              ),
            ],
          ),
        ));
  }
}
