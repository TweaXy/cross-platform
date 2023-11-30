import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/login/forget_password_page3.dart';

class ForgetPasswordPage1 extends StatefulWidget {
  const ForgetPasswordPage1({super.key});

  @override
  State<ForgetPasswordPage1> createState() => _LoginViewPage1State();
}

class _LoginViewPage1State extends State<ForgetPasswordPage1> {
  TextEditingController myController = TextEditingController();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    myController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = myController.text.trim().isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(
        iconButton: IconButton(
          icon: const Icon(
            Icons.close_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Scaffold(
        body: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04,
                      right: MediaQuery.of(context).size.width * 0.04,
                      top: MediaQuery.of(context).size.height * 0.03),
                  child: const Text(
                    'Find your X account',
                    overflow: TextOverflow.clip,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
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
                'Enter the email or username associated with your account to change your password',
                overflow: TextOverflow.fade,
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: !isDarkMode ? Colors.black45 : Colors.white38),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width * 0.06,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04),
              child: CustomTextField(
                key: const ValueKey(SignInKeys.forgetPasswordEmailFieldKey),
                validatorFunc: () {},
                label: 'Email address or Username',
                controller: myController,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CustomButton(
                            key: const ValueKey(SignInKeys.nextButtonKey),
                            color: forgroundColorTheme(context),
                            text: 'Next',
                            initialEnabled: isButtonEnabled,
                            onPressedCallback: () async {
                              SignInServices.setEmail(email: myController.text);
                              String res =
                                  await SignInServices.forgetPassword();

                              //  print(res);
                              if (res != 'success') {
                                showToastWidget(
                                    CustomToast(
                                      message: res,
                                      screenWidth: screenWidth,
                                    ),
                                    position: ToastPosition.bottom,
                                    duration: const Duration(seconds: 2));
                              } else {
                                Navigator.pop(context);
                                Navigator.push(
                                    context,
                                    CustomPageRoute(
                                        direction: AxisDirection.left,
                                        child: const ForgetPasswordPage3()));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
