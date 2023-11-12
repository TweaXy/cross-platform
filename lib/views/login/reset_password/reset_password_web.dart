import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_dialog_app_bar.dart';
import 'package:tweaxy/views/login/reset_password/reset_password_web2.dart';
import 'package:tweaxy/components/custom_appbar_web.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class ResetPasswordWeb extends StatefulWidget {
  const ResetPasswordWeb({super.key});

  @override
  State<ResetPasswordWeb> createState() => _ResetPasswordWebState();
}

class _ResetPasswordWebState extends State<ResetPasswordWeb> {
  TextEditingController myControllerNewPassword = TextEditingController();
  TextEditingController myControllerConfirmPassword = TextEditingController();

  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    myControllerNewPassword.addListener(_updateButtonState);
    myControllerConfirmPassword.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      String c1 = myControllerNewPassword.text;
      String c2 = myControllerConfirmPassword.text;
      if (!myControllerNewPassword.text.isEmpty && (c1 == c2))
        isButtonEnabled = true;
      else
        isButtonEnabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          CustomDialogAppBar(isDarkMode: true),
          Padding(
            padding: EdgeInsets.only(
                left: screenwidth * 0.02,
                right: screenwidth * 0.02,
                top: screenheight * 0.01),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeadText(
                  size: 35,
                  textValue: 'Choose a new password',
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.02),
                  child: RichText(
                    text: const TextSpan(
                      text:
                          "Make sure your new password is 8 characters or more. Try including numbers, letters, and punctuation marks for a",
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: Colors.black54),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' strong password',
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 17,
                                color: Colors.blue)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: screenheight * 0.02,
                    bottom: screenheight * 0.04,
                  ),
                  child: CustomTextField(
                    key: const ValueKey("ResetPasswordWebNewPass"),
                    label: "Enter a new password",
                    validatorFunc: passwordValidation,
                    controller: myControllerNewPassword,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: screenheight * 0.03,
                  ),
                  child: CustomTextField(
                    key: const ValueKey("ResetPasswordWebConfirmPass"),
                    label: "Confirm your password",
                    validatorFunc: passwordValidation,
                    controller: myControllerConfirmPassword,
                  ),
                ),
              ],
            ),
          ),
          Column(
            // crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(top: screenheight * 0.21),
                child: SizedBox(
                    width: 500,
                    height: 50,
                    child: CustomButton(
                        key: const ValueKey("ResetPasswordWebNext"),
                        color: forgroundColorTheme(context),
                        text: 'Change Password',
                        onPressedCallback: () async {
                          String res = await SignInServices.resetPassword(
                              myControllerNewPassword.text);
                          if (res != 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('$res'),
                                backgroundColor: Colors.blue,
                              ),
                            );
                          } else {
                            Navigator.pop(context);
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                content: ResetPasswordWeb2(),
                              ),
                              barrierColor:
                                  const Color.fromARGB(100, 97, 119, 129),
                              barrierDismissible: false,
                            );
                          }
                        },
                        initialEnabled: isButtonEnabled)),
              ),
            ],
          )
        ],
      ),
    );
  }
}
