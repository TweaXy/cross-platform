import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_dialog_app_bar.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/login/forget_passwoed_web_3.dart';

class ForgetPasswordWeb2 extends StatelessWidget {
  const ForgetPasswordWeb2({super.key, required this.email});
  final String email;

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Builder(builder: (BuildContext scaffoldContext) {
        return Scaffold(
          body: Column(children: [
            CustomDialogAppBar(isDarkMode: !isDarkMode),
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      'Where should we send a confirmation code?',
                      style: GoogleFonts.robotoFlex(
                        color: !isDarkMode ? Colors.black87 : Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      '\nBefore you can change your password, we need to make sure it\'s really you.',
                      style: GoogleFonts.robotoSlab(
                        color: !isDarkMode ? Colors.black54 : Colors.white24,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(
                      '\nLet\'s text a code to the phone number ending in 47.',
                      style: GoogleFonts.roboto(
                          color: !isDarkMode ? Colors.black87 : Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 280,
                  ),
                  Column(
                    // crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 400,
                        child: CustomButton(
                            key: const ValueKey('nextForgetScreen2'),
                            color: forgroundColorTheme(context),
                            text: 'Next',
                            onPressedCallback: () async {
                              String res = SignInServices.forgetPassword();

                              if (res != 'sucess') {
                                ScaffoldMessenger.of(scaffoldContext)
                                    .showSnackBar(
                                  SnackBar(content: Text(res)),
                                );
                              } else {
                                Navigator.pop(context);
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    content: ForgetPasswordWeb3(),
                                  ),
                                  barrierColor:
                                      const Color.fromARGB(100, 97, 119, 129),
                                  barrierDismissible: false,
                                );
                              }
                            },
                            initialEnabled: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: SizedBox(
                          height: 50,
                          width: 400,
                          child: CustomButton(
                              key: const ValueKey('cancelForgetScreen2'),
                              color: backgroundColorTheme(context),
                              text: 'Cancel',
                              onPressedCallback: () {
                                Navigator.pop(context);
                              },
                              initialEnabled: true),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        );
      }),
    );
  }
}
