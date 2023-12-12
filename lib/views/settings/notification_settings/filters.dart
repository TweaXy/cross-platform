import 'package:flutter/material.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/views/settings/notification_settings/fitered_notifications.dart';

class Filters extends StatefulWidget {
  const Filters({super.key});

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const SettingsAppBar(
        title: "Filters",
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
                          horizontal: MediaQuery.of(context).size.width * .01),
                      child: CustomParagraphText(
                        textValue:
                            "Choose the notifications you'd like to see--and those you don't",
                        textAlign: TextAlign.start,
                        size: 17,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .02),
                  child: ListTile(
                    leading: const Text(
                      "Muted notificatios",
                      style: TextStyle(fontSize: 20),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.arrow_forward_ios),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CustomPageRoute(
                                direction: AxisDirection.left,
                                child: const FilteredNotification()));
                      },
                    ),
                  ),
                ),
                ListTile(
                  leading: const Text(
                    "Muted words",
                    style: TextStyle(fontSize: 20),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
