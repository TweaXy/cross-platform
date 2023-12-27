import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/logout_service.dart';
import 'package:tweaxy/shared/keys/settings_keys.dart';
import 'package:tweaxy/views/settings/update_email/password_varification_view.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/settings/update_email_components/custom_data_display.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/views/settings/update_username_view.dart';

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
      appBar: const SettingsAppBar(
        title: "Account information",
      ),
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
                  onpress: () {
                    Navigator.push(
                        context,
                        CustomPageRoute(
                            direction: AxisDirection.left,
                            child: const UpdateUsernameView()));
                  },
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
                  key: const ValueKey(SettingsKeys.logOut),
                  title: "Log out",
                  subtitle: "",
                  onpress: () async {
                   
                    dynamic response = await LOGOUT(Dio()).logOutDevice();
                    if (response is String) {
                      showToastWidget(
                        CustomToast(
                          message: response.toString(),
                        ),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2),
                      );
                    } else {
                       SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    await preferences.clear();
                      if (mounted) {

                        Navigator.popUntil(context, (route) => route.isFirst);
                        Navigator.pushReplacementNamed(context, kSplashScreen);
                      }
                    }
                    // todo: log out the app and clear shared preference
                  },
                ),
              ]),
        ),
      ),
    );
  }
}
