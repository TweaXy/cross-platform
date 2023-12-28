import 'package:flutter/material.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/settings/update_email_components/custom_data_display.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/views/settings/mutes_and_blocks/mute_and_blocks_screen.dart';

class SettingsPrivacySafetyScreen extends StatelessWidget {
  const SettingsPrivacySafetyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(
        title: "Privacy and safety",
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * .02),
        child: CustomdataDisplay(
          lead: const Icon(
            Icons.volume_off_outlined,
          ),
          title: 'Mute and block',
          subtitle:
              'Manage the accounts and notifications that you\'ve muted or blocked',
          onpress: () {
            Navigator.push(
                context,
                CustomPageRoute(
                    direction: AxisDirection.left,
                    child: const MuteAndBlockScreen()));
          },
        ),
      ),
    );
  }
}
