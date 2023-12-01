import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:sign_button/sign_button.dart';
import 'package:tweaxy/components/sign_in_with.dart';
import 'package:tweaxy/components/start_screen_divider.dart';
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
  Future SignIn() async {
    final user = await GoogleSignINApi.login();
    if (user == null) {
      CustomWebToast(message: "errrrrrrrrrrrrrrrrrrrrrr");
    } else {
      Navigator.of(context).popUntil((route) => route.isFirst);
      Navigator.of(context).pushReplacementNamed(kHomeScreen);
    }
  }

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
                SignIn();
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
              }
            },
            size: ButtonSize.medium,
          ),
        ),
        StartScreenDivider(isDarkMode: widget.isDarkMode),
      ],
    );
  }
}
