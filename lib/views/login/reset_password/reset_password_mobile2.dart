import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/login/forget_password_page1.dart';

// ignore: must_be_immutable
class ResetPasswordMobile2 extends StatefulWidget {
  const ResetPasswordMobile2({super.key});

  @override
  State<ResetPasswordMobile2> createState() => _ResetPasswordMobile2State();
}

class _ResetPasswordMobile2State extends State<ResetPasswordMobile2> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Center(
            child: SafeArea(
              child: SvgPicture.asset(
                'assets/images/logo.svg',
                alignment: Alignment.center,
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.78,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: screenwidth * 0.3,
                        top: screenheight * 0.1,
                      ),
                      child: Text(
                        'You\'re all set',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: screenwidth * 0.1, bottom: screenheight * 0.05),
                      child: CustomParagraphText(
                          textValue:
                              'You\'ve successfully changed your password',
                          textAlign: TextAlign.left),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: screenwidth - screenwidth * 0.2,
                        child: CustomButton(
                          key: const ValueKey(
                              SignInKeys.forgetPasswordContinueButtonKey),
                          color: forgroundColorTheme(context),
                          text: 'Continue to TweaXy',
                          initialEnabled: true,
                          onPressedCallback: () {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                            Navigator.pushReplacementNamed(
                                context, kHomeScreen);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.end,
              //     children: [
              //       const Divider(),
              //       Align(
              //         alignment: Alignment.bottomRight,
              //         child:
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),
        ));
  }
}
