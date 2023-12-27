import 'package:flutter/material.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/views/settings/mutes_and_blocks/blocked_users_screen.dart';
import 'package:tweaxy/views/settings/mutes_and_blocks/muted_users_screen.dart';

class MuteAndBlockScreen extends StatelessWidget {
  const MuteAndBlockScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SettingsAppBar(
          title: "Mute and block",
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 12, 4, 12),
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: 'Manage the accounts that you\'ve muted or blocked',
                  style: TextStyle(
                      color: Colors.blueGrey[700],
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
            ListTile(
              title: const Text('Blocked accounts'),
              onTap: () {
                Navigator.push(
                    context,
                    CustomPageRoute(
                        direction: AxisDirection.left,
                        child: const BlockedUserScreen()));
              },
            ),
            ListTile(
              title: const Text('Muted accounts'),
              onTap: () {
                Navigator.push(
                    context,
                    CustomPageRoute(
                        direction: AxisDirection.left,
                        child: const MutedUsersScreen()));
              },
            ),
          ],
        ));
  }
}
