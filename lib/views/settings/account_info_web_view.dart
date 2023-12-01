import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/settings/update_email_components/custom_data_display.dart';
import 'package:tweaxy/models/app_icons.dart';

class AccountInfoWebView extends StatefulWidget {
  const AccountInfoWebView({super.key});

  @override
  State<AccountInfoWebView> createState() => _AccountInfoWebViewState();
}

class _AccountInfoWebViewState extends State<AccountInfoWebView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
                  size: 15,
                  textValue: "See information about your Account.",
                  textAlign: TextAlign.start),
            ),
          ),
        ),
        CustomdataDisplay(
          key: const ValueKey("account information view navigator"),
          title: "Account information",
          subtitle:
              "See your account information like your phone number and email address.",
          onpress: () {
            // Navigator.push(
            //     context,
            //     CustomPageRoute(
            //         direction: AxisDirection.left,
            //         child: const AccountIfoView()));
          },
          lead: const Icon(AppIcon.profile),
        ),
          CustomdataDisplay(
              title: "Change your password",
              subtitle: "change your password at anytime.",
              onpress: () {},
              lead: const Icon(Icons.lock_outline),
            ),
      ],
    );
  }
}
