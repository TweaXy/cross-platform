import 'package:flutter/material.dart';
import 'package:tweaxy/Views/settings/update_email/accout_info.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/components/update_email_components/custom_appbar.dart';
import 'package:tweaxy/components/update_email_components/custom_data_display.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbarwidget(),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .04),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * .01),
                  child: CustomParagraphText(
                      textValue: "See information about your Account.",
                      textAlign: TextAlign.start),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .01),
                child: CustomdataDisplay(
                  key:const ValueKey("account information view navigator"),
                  title: "Account information",
                  subtitle:
                      "See your account information like your ohone number and email address.",
                  onpress: () {
                    Navigator.push(
                        context,
                        CustomPageRoute(
                            direction: AxisDirection.left,
                            child: const AccountIfoView()));
                  },
                  lead: const Icon(Icons.person),
                ),
              ),
              CustomdataDisplay(
                title: "Change your password",
                subtitle: "change your password at anytime.",
                onpress: () {},
                lead: const Icon(Icons.lock),
              ),
            ]),
      ),
    );
  }
}
