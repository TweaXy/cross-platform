import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/Views/settings/update_email/password_varification_view.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/components/update_email_components/custom_appbar.dart';
import 'package:tweaxy/components/update_email_components/custom_data_display.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/temp_user.dart';

class AccountIfoView extends StatefulWidget {
  const AccountIfoView({super.key});

  @override
  State<AccountIfoView> createState() => _AccountIfoViewState();
}

class _AccountIfoViewState extends State<AccountIfoView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppbarwidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.01),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomdataDisplay(
                  key: const ValueKey("username_update_button"),
                  onpress: () {},
                  title: "Username",
                  subtitle: TempUser.username,
                ),
                CustomdataDisplay(
                  key: const ValueKey("email_update_button"),
                  onpress: () {
                    Navigator.push(
                        context,
                        CustomPageRoute(
                            direction: AxisDirection.left,
                            child: const PasswordVarificationView()));
                  },
                  title: "Email",
                  subtitle: TempUser.email,
                ),
                CustomdataDisplay(
                                    key: const  ValueKey("logout_update_button"),

                  title: "Log out",
                  subtitle: "",
                  onpress: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacementNamed(context, kSplashScreen);
                    setState(() async {
                      SharedPreferences preferences =
                          await SharedPreferences.getInstance();
                      await preferences.clear();
                    });

                    // todo: log out the app and clear shared preference
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
