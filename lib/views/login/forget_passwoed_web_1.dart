import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/Views/login/forget_passwoed_web_3.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_dialog_app_bar.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/sign_choose.dart';
import 'package:tweaxy/components/text_and_link.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

// ignore: must_be_immutable
class ForgetPasswordWeb1 extends StatefulWidget {
  ForgetPasswordWeb1({super.key});

  @override
  State<ForgetPasswordWeb1> createState() => _WebDialogSignInPage2State();
}

class _WebDialogSignInPage2State extends State<ForgetPasswordWeb1> {
  TextEditingController myController = TextEditingController();
  bool isButtonEnabled = false;
  bool isSnackBarShown = false; // Added flag to track SnackBar visibility
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
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomDialogAppBar(isDarkMode: isDarkMode),
          const Padding(
            padding: const EdgeInsets.only(left: 50),
            child: Row(
              children: [
                Text(
                  'Find your TweaXy account',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50, top: 15),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    'Enter the email, phone number, or username associated with your account to change your password.',
                    overflow: TextOverflow.visible,
                    softWrap: true,
                    style: TextStyle(
                        fontSize: 18,
                        color: isDarkMode ? Colors.black45 : Colors.white38),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: 500,
              height: 70,
              child: CustomTextField(
                  label: 'Phone, email address, username',
                  validatorFunc: emailValidation,
                  controller: myController),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SizedBox(
                        width: 500,
                        height: 40,
                        child: CustomButton(
                            color: forgroundColorTheme(context),
                            text: 'Login',
                            onPressedCallback: () async {
                              SignInServices.setEmail(email: myController.text);
                              String res =
                                  await SignInServices.forgetPassword();

                              print(res);
                              if (res != 'success') {
                                showToastWidget(
                                    CustomWebToast(
                                      message: res,
                                    ),
                                    position: ToastPosition.bottom,
                                    duration: const Duration(seconds: 2));
                              } else {
                                Navigator.pop(context);

                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: ForgetPasswordWeb3(),
                                  ),
                                  barrierColor:
                                      const Color.fromARGB(100, 97, 119, 129),
                                  barrierDismissible: false,
                                );
                              }
                            },
                            initialEnabled: isButtonEnabled)),
                  ),
                  Container(height: 30)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
