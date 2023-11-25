import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/views/login/reset_password/reset_password_mobile.dart';
// import 'package:tweaxy/views/login/resetpassword/reset_password_mobile.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/login/forget_password_page1.dart';
import 'package:tweaxy/views/login/forget_password_page2.dart';
import 'package:tweaxy/views/login/login_view_page2.dart';

class ForgetPasswordPage3 extends StatefulWidget {
  const ForgetPasswordPage3({super.key});

  @override
  State<ForgetPasswordPage3> createState() => _LoginViewPage1State();
}

class _LoginViewPage1State extends State<ForgetPasswordPage3> {
  TextEditingController myController = TextEditingController();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    myController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = myController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(
        iconButton: IconButton(
          key: const ValueKey("forgetPassView3BackIcon"),
          icon: Icon(
            Icons.close_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.04,
                    top: MediaQuery.of(context).size.height * 0.02),
                child: Text(
                  'We sent you a code',
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.02,
                left: MediaQuery.of(context).size.width * 0.04,
                right: MediaQuery.of(context).size.width * 0.04),
            child: Text(
              'Check your email to get your confirmation code. if you need to request a new code, go back and reselect a confimation method.',
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: !isDarkMode ? Colors.black45 : Colors.white38),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.03),
            child: CustomTextField(
              key:
                  const ValueKey(SignInKeys.forgetPasswordVerificationFieldKey),
              validatorFunc: codeValidation,
              label: 'Enter your code',
              controller: myController,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Divider(
                  color: Colors.black26,
                  height: MediaQuery.of(context).size.height * 0.01,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                      vertical: MediaQuery.of(context).size.height * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        key: const ValueKey("forgetPassView3BackButton"),
                        color: backgroundColorTheme(context),
                        text: 'Back',
                        initialEnabled: true,
                        onPressedCallback: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              CustomPageRoute(
                                  direction: AxisDirection.left,
                                  child: ForgetPasswordPage1()));
                        },
                      ),
                      CustomButton(
                        key: const ValueKey(SignInKeys.nextButtonKey),
                        color: forgroundColorTheme(context),
                        text: 'Next',
                        initialEnabled: isButtonEnabled,
                        onPressedCallback: () async {
                          SignInServices.setToken(token: myController.text);
                          String res = await SignInServices.checkResetToken();

                          print(res);

                          if (res != 'success') {
                            showToastWidget(
                                CustomToast(
                                  message: res,
                                ),
                                position: ToastPosition.bottom,
                                duration: const Duration(seconds: 2));
                          } else {
                            SignInServices.setToken(token: myController.text);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                CustomPageRoute(
                                    direction: AxisDirection.left,
                                    child: ResetPasswordMobile()));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
