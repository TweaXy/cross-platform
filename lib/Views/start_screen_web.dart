import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tweaxy/Components/sign_choose.dart';
import 'package:tweaxy/Components/start_screen_signup_button.dart';
import 'package:tweaxy/Components/web_main_dialog.dart';

class WebStartScreen extends StatelessWidget {
  const WebStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery.of(context).platformBrightness;
    bool isDarkMode = brightness == Brightness.dark;
    var dialogWidth = MediaQuery.of(context).size.width / 3 - 20;
    var dialogHeight = MediaQuery.of(context).size.height * 0.75 - 20;
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 3,
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              alignment: Alignment.center,
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 50.0),
                    child: Text(
                      'Happening now',
                      style: TextStyle(
                        fontSize: 68,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 28.0),
                    child: Text(
                      'Join today',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 350,
                    child: Column(
                      children: [
                        SignChoose(isDarkMode: isDarkMode),
                        StartScreenSignupButton(
                            key: const ValueKey('webSignupStartScreen'),
                            isDarkMode: isDarkMode)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(bottom: 18.0),
                          child: Text(
                            'Already Have An Account ?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 350,
                          height: 40,
                          child: OutlinedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => WebMainDialog(
                                  dialogWidth: dialogWidth,
                                  dialogHeight: dialogHeight,
                                  isDarkMode: isDarkMode,
                                ),
                                barrierColor:
                                    const Color.fromARGB(100, 97, 119, 129),
                                barrierDismissible: false,
                              );
                            },
                            key: const ValueKey('webStartScreenLogin'),
                            style: ButtonStyle(
                              shape: MaterialStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            ),
                            child: const Text("Sign In"),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
