import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sign_button/sign_button.dart';
import 'package:tweaxy/components/sign_in_with.dart';
import 'package:tweaxy/components/start_screen_divider.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/sign_in_google.dart';

class SignChoose extends StatefulWidget {
  const SignChoose({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  State<SignChoose> createState() => _SignChooseState();
}

class _SignChooseState extends State<SignChoose> {
///////////////////////////////

///////////////////
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: SignWithButton(
            type: widget.isDarkMode ? ButtonType.googleDark : ButtonType.google,
            onPressed: () async {
              try {
                Map<String, dynamic> user =
                    await GoogleAPI().login() as Map<String, dynamic>;
                if (user == null) {
                  showToastWidget(
                    CustomToast(
                      message: 'Faild to login with google',
                    ),
                    position: ToastPosition.bottom,
                    duration: const Duration(seconds: 2),
                  );
                } else {
                  Navigator.of(context).popUntil((route) => route.isFirst);
                  Navigator.of(context).pushReplacementNamed(kHomeScreen);
                }
              } on DioException catch (e) {
                showToastWidget(
                  CustomToast(
                    message: e.response!.data['message'],
                  ),
                  position: ToastPosition.bottom,
                  duration: const Duration(seconds: 2),
                );
              } on Exception catch (e) {
                // ignore: use_build_context_synchronously
                // showSnackBar(context, e);
                showToastWidget(
                  CustomToast(message: e.toString()),
                  position: ToastPosition.bottom,
                  duration: const Duration(seconds: 2),
                );
              }
            },
            size: ButtonSize.medium,
          ),
        ),
        // SizedBox(
        //   width: double.infinity,
        //   child: SignWithButton(
        //     type: !isDarkMode ? ButtonType.facebook : ButtonType.facebookDark,
        //     onPressed: () {
        //       //TODO: implement continue with facebook logic
        //     },
        //     size: ButtonSize.large,
        //   ),
        // ),
        // SizedBox(
        //   width: double.infinity,
        //   child: SignWithButton(
        //     type: !isDarkMode ? ButtonType.github : ButtonType.githubDark,
        //     onPressed: () {
        //       //TODO: implement continue with github logic
        //       var res = SignInServices.signInGithub();
        //       // print("sign in" + res.toString());
        //     },
        //     size: ButtonSize.medium,
        //   ),
        // ),
        StartScreenDivider(isDarkMode: widget.isDarkMode),
      ],
    );
  }
}
