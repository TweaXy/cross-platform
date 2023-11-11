import 'package:flutter/material.dart';
import 'package:sign_button/sign_button.dart';
import 'package:tweaxy/components/sign_in_with.dart';
import 'package:tweaxy/components/start_screen_divider.dart';
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
            onPressed: () {
              //TODO: implement continue with google logic
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
