import 'package:flutter/material.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/settings/update_email_components/custom_data_display.dart';

class NoticicationSettingsView extends StatefulWidget {
  const NoticicationSettingsView({super.key});

  @override
  State<NoticicationSettingsView> createState() =>
      _NoticicationSettingsViewState();
}

class _NoticicationSettingsViewState extends State<NoticicationSettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(
        title: "Notifications",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.02),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.50,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * .01),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * .02),
                      child: CustomParagraphText(
                        textValue:
                            "Select kinds of notifications you get about your activation, interests, and recommendations",
                        textAlign: TextAlign.start,
                        size: 17,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .02),
                  child: CustomdataDisplay(
                    onpress: () {},
                    title: "Filters",
                    subtitle:
                        "Choose the notifications you'd like to see -- and those you don't",
                    lead: const Icon(Icons.notifications_on_rounded),
                  ),
                ),
                CustomdataDisplay(
                  onpress: () {},
                  title: "Preferences",
                  subtitle: "Select your preferences by notification type",
                  lead: const Icon(Icons.phonelink_ring_outlined),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
