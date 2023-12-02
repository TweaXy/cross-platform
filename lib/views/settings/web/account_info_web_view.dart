import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/settings/update_email_components/custom_data_display.dart';
import 'package:tweaxy/cubits/setting-web-cubit/settings_web_cubit.dart';
import 'package:tweaxy/cubits/sidebar_cubit/sidebar_cubit.dart';
import 'package:tweaxy/models/app_icons.dart';

class AccountInfoWebView extends StatefulWidget {
  const AccountInfoWebView({super.key});

  @override
  State<AccountInfoWebView> createState() => _AccountInfoWebViewState();
}

class _AccountInfoWebViewState extends State<AccountInfoWebView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 0.5,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ListTile(
            title: Text("Your Account",
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                  fontSize: 20,
                  letterSpacing: 0.4,
                )),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * .01,
                vertical: MediaQuery.of(context).size.height * .01),
            child: CustomParagraphText(
                size: 15,
                textValue: "See information about your Account.",
                textAlign: TextAlign.start),
          ),
          CustomdataDisplay(
            key: const ValueKey("account information view navigator"),
            title: "Account information",
            subtitle:
                "See your account information like your phone number and email address.",
            onpress: () {
              _globalOnTap(0);
            },
            lead: const Icon(AppIcon.profile),
          ),
          CustomdataDisplay(
            title: "Change your password",
            subtitle: "change your password at anytime.",
            onpress: () {
              _globalOnTap(1);
            },
            lead: const Icon(Icons.lock_outline),
          ),
        ],
      ),
    );
  }

  void _globalOnTap(index) {
    BlocProvider.of<SettingsWebCubit>(context).toggleMenu(index);
  }
}
