import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';

class FilteredNotification extends StatefulWidget {
  const FilteredNotification({super.key});

  @override
  State<FilteredNotification> createState() => _FilteredNotificationState();
}

class _FilteredNotificationState extends State<FilteredNotification> {
  bool dontFollow = false;
  bool whoDontFollow = false;
  bool newAccount = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * 0.07),
        child: SingleChildScrollView(
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
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.02,
                        vertical: MediaQuery.of(context).size.height * 0.01),
                    child: CustomHeadText(
                        size: 22,
                        textValue: "Mute notifications from people",
                        textAlign: TextAlign.start),
                  ),
                  CheckboxListTile(
                    title: const Text(
                      "You don't follow",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        dontFollow = value!;
                      });
                    },
                    value: dontFollow,
                  ),
                  CheckboxListTile(
                    title: const Text(
                      "Who don't follow you",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        whoDontFollow = value!;
                      });
                    },
                    value: whoDontFollow,
                  ),
                  CheckboxListTile(
                    title: const Text(
                      "With a new account",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        newAccount = value!;
                      });
                    },
                    value: newAccount,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.03),
                    child: CustomParagraphText(
                        size: 17,
                        textValue:
                            "These filters will not affect notifications from people you follow",
                        textAlign: TextAlign.start),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
