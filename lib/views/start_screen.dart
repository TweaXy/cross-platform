import 'package:flutter/material.dart';
import 'package:tweaxy/components/sign_choose.dart';
import 'package:tweaxy/components/start_screen_signup_button.dart';
import 'package:tweaxy/components/text_and_link.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.09,
                vertical: MediaQuery.of(context).size.height * 0.07),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                ),
                const Center(
                  child: Text(
                    'See What\'s happening in the world right now.',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.06,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      SignChoose(isDarkMode: isDarkMode),
                      StartScreenSignupButton(
                        key: const ValueKey('signupStartScreen'),
                        isDarkMode: isDarkMode,
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TextAndLink(
                    text: 'Have an account already? ',
                    linkedText: 'Log in',
                    linkKey: const ValueKey(welcomePagelogInButtonKey),
                    onPressed: () {
                      Navigator.pushNamed(context, kLogin1Screen);
                    },
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
