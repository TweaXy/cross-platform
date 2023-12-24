import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/AppBar/settings_appbar.dart';
import 'package:tweaxy/components/settings/update_email_components/custom_data_display.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/models/app_icons.dart';
import 'package:tweaxy/services/notification_settings_service.dart';
import 'package:tweaxy/shared/keys/settings_keys.dart';
import 'package:tweaxy/views/settings/mutes_and_blocks/settings_privacy_safety_screen.dart';
// import 'package:tweaxy/views/settings/notification_settings/notification_settings_view.dart';
import 'package:tweaxy/views/settings/settings_view.dart';

class SettingsAndPrivacyView extends StatefulWidget {
  SettingsAndPrivacyView({super.key});

  @override
  State<SettingsAndPrivacyView> createState() => _SettingsAndPrivacyViewState();
}

class _SettingsAndPrivacyViewState extends State<SettingsAndPrivacyView> {
  String? deviceToken;

  Future setNotificationSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    deviceToken = prefs.getString("notificationTokenSent");
    String response = await NotificationSettingsService(Dio())
        .notificatioCheckState(deviceToken!);
    // String response = "true";
    if (response == "true") {
      setState(() {
        notiifcationEnable = true;
      });
    } else if (response == "false") {
      setState(() {
        notiifcationEnable = false;
      });
    } else {
      showToastWidget(
        CustomToast(
            message:
                "error in loading notification settings state error\n$response"),
        position: ToastPosition.bottom,
        duration: const Duration(seconds: 2),
      );
    }
  }

  bool? notiifcationEnable;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future(() async => await setNotificationSettings());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const SettingsAppBar(
          key: ValueKey(SettingsKeys.backIcon),
          title: "Settings",
        ),
        body: notiifcationEnable == null
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.blue,
                ),
              )
            : Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .02),
                        child: CustomdataDisplay(
                          key: const ValueKey(SettingsKeys.yourAccount),
                          lead: const Icon(AppIcon.profile),
                          title: "Your account",
                          subtitle:
                              "See information about your account, and make changes to your them.",
                          onpress: () {
                            Navigator.push(
                                context,
                                CustomPageRoute(
                                    direction: AxisDirection.left,
                                    child: const SettingsView()));
                          },
                        ),
                      ),
                      // CustomdataDisplay(
                      //   key: const ValueKey(SettingsKeys.notifications),
                      //   lead: const Icon(AppIcon.notification),
                      //   title: "Notifications",
                      //   subtitle:
                      //       "Select the kinds of notifications you get about your activity,intrests and recommendations.",
                      //   onpress: () {
                      //     Navigator.push(
                      //         context,
                      //         CustomPageRoute(
                      //             direction: AxisDirection.left,
                      //             child: const NoticicationSettingsView()));
                      //   },
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: MediaQuery.of(context).size.height * .02),
                        child: CustomdataDisplay(
                          lead: const Icon(Icons.verified_user_outlined),
                          title: 'Privacy and safety',
                          subtitle:
                              'Manage what information you see and share on TweaXy',
                          onpress: () {
                            Navigator.push(
                                context,
                                CustomPageRoute(
                                    direction: AxisDirection.left,
                                    child:
                                        const SettingsPrivacySafetyScreen()));
                          },
                        ),
                      ),
                      SwitchListTile(
                        secondary: const Icon(AppIcon.notificationIcon),
                        title: const Text(
                          'Notification Enable',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: kIsWeb ? 15 : 20,
                          ),
                        ),
                        value: notiifcationEnable!,
                        onChanged: (bool value) async {
                          if (value == true) {
                            dynamic response =
                                await NotificationSettingsService(Dio())
                                    .notificatioEnable(deviceToken!);
                            if (response is String) {
                              showToastWidget(
                                CustomToast(message: response.toString()),
                                position: ToastPosition.bottom,
                                duration: const Duration(seconds: 2),
                              );
                            } else {
                              setState(() {
                                notiifcationEnable = value;
                              });
                            }
                          } else {
                            dynamic response =
                                await NotificationSettingsService(Dio())
                                    .notificatioDisable(deviceToken!);
                            if (response is String) {
                              showToastWidget(
                                CustomToast(message: response.toString()),
                                position: ToastPosition.bottom,
                                duration: const Duration(seconds: 2),
                              );
                            } else {
                              setState(() {
                                notiifcationEnable = value;
                              });
                            }
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ));
  }
}
