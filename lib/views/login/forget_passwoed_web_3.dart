import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/views/login/reset_password/reset_password_web.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_dialog_app_bar.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/login/forget_passwoed_web_1.dart';

import '../../services/sign_in.dart';

class ForgetPasswordWeb3 extends StatefulWidget {
  const ForgetPasswordWeb3({super.key});

  @override
  State<ForgetPasswordWeb3> createState() => _ForgetPasswordWeb3State();
}

class _ForgetPasswordWeb3State extends State<ForgetPasswordWeb3> {
  bool isButtonEnabled = false;
  TextEditingController myController = TextEditingController();

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
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomDialogAppBar(isDarkMode: !isDarkMode),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 40,
                      top: 20,
                    ),
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
                padding: const EdgeInsets.only(top: 15, left: 40, right: 40),
                child: Text(
                  'Check your phone to get your confirmation code. if you need to requst a new code, go back and reselect a confimation method.',
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: !isDarkMode ? Colors.black87 : Colors.white38,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: SizedBox(
                  height: 90,
                  width: 500,
                  child: CustomTextField(
                    key: const ValueKey("forgetPassView3TextField"),
                    validatorFunc: codeValidation,
                    label: 'Enter your code',
                    controller: myController,
                  ),
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                            height: 50,
                            width: 480,
                            child: CustomButton(
                              key: const ValueKey("forgetPassView3BackButton"),
                              color: isButtonEnabled
                                  ? forgroundColorTheme(context)
                                  : backgroundColorTheme(context),
                              text: isButtonEnabled ? 'Next' : 'Back',
                              initialEnabled: true,
                              onPressedCallback: () async {
                                // if (isButtonEnabled)
                                SignInServices.setToken(
                                    token: myController.text);
                                String res =
                                    await SignInServices.checkResetToken();

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
                                      content: isButtonEnabled
                                          ? ResetPasswordWeb()
                                          : ForgetPasswordWeb1(),
                                    ),
                                    barrierColor:
                                        const Color.fromARGB(100, 97, 119, 129),
                                    barrierDismissible: false,
                                  );
                                }
                              },
                            )),
                        Container(height: 30)
                      ]),
                ),
              )
            ],
          ),
        ));
  }
}
