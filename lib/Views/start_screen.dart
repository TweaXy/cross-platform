import 'package:flutter/material.dart';
import 'package:tweaxy/components/sign_choose.dart';
import 'package:tweaxy/components/start_screen_signup_button.dart';
import 'package:tweaxy/components/text_and_link.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            children: [
              const Spacer(
                flex: 3,
              ),
              const Center(
                child: Text(
                  'See What\'s happening in the world right now.',
                  style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                ),
              ),
              const Spacer(
                flex: 4,
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    SignChoose(isDarkMode: isDarkMode),
                    StartScreenSignupButton(
                        key: const ValueKey('signupStartScreen'),
                        isDarkMode: isDarkMode)
                  ],
                ),
              ),
              const Spacer(
                flex: 1,
              ),
              SizedBox(
                width: double.infinity,
                child: TextAndLink(
                  text: 'Have an account already? ',
                  linkedText: 'Log in',
                  linkKey: const ValueKey('startScreenLinkLogin'),
                  onPressed: () {},
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
