import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sign_button/sign_button.dart';
import 'package:tweaxy/components/sign_in_with.dart';
import 'package:tweaxy/components/start_screen_divider.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/login_api.dart';
import 'package:tweaxy/services/sign_in.dart';

class SignChoose extends StatelessWidget {
  const SignChoose({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: SignWithButton(
            type: isDarkMode ? ButtonType.googleDark : ButtonType.google,
            onPressed: () async {
              try {
                Map<String, dynamic> loginGoogle =
                    await LoginApi().SignInWithGoogle();
                if (loginGoogle['status'] == "success") {
                  //go to home page
                  print(loginGoogle);
                  Navigator.pushNamed(context, kStartScreen);
                }
              } on DioException catch (e) {
                print('DioException: ${e.toString()}');
                // ignore: use_build_context_synchronously
                // showSnackBar(context, e.response!.data['message']);
                showToastWidget(
                  CustomWebToast(
                    message: e.response!.data['message'],
                  ),
                  position: ToastPosition.bottom,
                  duration: const Duration(seconds: 2),
                );
              } on Exception catch (e) {
                print(e.toString());
                if (kIsWeb) {
                  showToastWidget(
                    CustomWebToast(
                      message: e.toString(),
                    ),
                    position: ToastPosition.bottom,
                    duration: const Duration(seconds: 2),
                  );
                } else {
                  showToastWidget(
                    CustomWebToast(
                      message: e.toString(),
                    ),
                    position: ToastPosition.bottom,
                    duration: const Duration(seconds: 2),
                  );
                }
                // ignore: use_build_context_synchronously
                // showSnackBar(context, e);
              }
            },
            size: ButtonSize.medium,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: SignWithButton(
            type: !isDarkMode ? ButtonType.facebook : ButtonType.facebookDark,
            onPressed: () {
              //TODO: implement continue with facebook logic
            },
            size: ButtonSize.large,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: SignWithButton(
            type: !isDarkMode ? ButtonType.github : ButtonType.githubDark,
            onPressed: () {
              //TODO: implement continue with github logic
              var res = SignInServices.signInGithub();
              // print("sign in" + res.toString());
            },
            size: ButtonSize.medium,
          ),
        ),
        StartScreenDivider(isDarkMode: isDarkMode),
      ],
    );
  }
}
