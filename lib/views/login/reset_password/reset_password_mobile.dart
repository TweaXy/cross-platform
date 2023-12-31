import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/views/login/reset_password/reset_password_mobile2.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/services/sign_in.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

// ignore: must_be_immutable
class ResetPasswordMobile extends StatefulWidget {
  const ResetPasswordMobile({super.key});

  @override
  State<ResetPasswordMobile> createState() => _ResetPasswordMobileState();
}

class _ResetPasswordMobileState extends State<ResetPasswordMobile> {
  TextEditingController myControllerNewPassword = TextEditingController();
  TextEditingController myControllerConfirmPassword = TextEditingController();

  bool isButtonEnabled = false;
  bool isValidPass = false;
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
      if (myControllerNewPassword.text.trim().isNotEmpty && (c1 == c2)) {
        isButtonEnabled = true;
      } else {
        isButtonEnabled = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(
        iconButton: IconButton(
          key: const ValueKey("ResetPasswordMobileBackIcon"),
          icon: const Icon(
            Icons.close_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.78,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      'Choose a new\npassword',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.only(
                        bottom: screenheight * 0.05,
                        top: screenheight * 0.03,
                        left: screenwidth * 0.04,
                        right: screenwidth * 0.08,
                      ),
                      child: RichText(
                        text: const TextSpan(
                          text:
                              "Make sure your new password is 8 characters or more. Try including numbers, letters, and punctuation marks for a",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20,
                              color: Colors.black54),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' strong password',
                                style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 20,
                                    color: Colors.blue)),
                          ],
                        ),
                      ),),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: screenheight * 0.06,
                      left: screenwidth * 0.04,
                      right: screenwidth * 0.04,
                    ),
                    child: CustomTextField(
                      key: const ValueKey(
                          SignInKeys.forgetPasswordNewPasswordFieldKey),
                      label: "Enter a new password",
                      validatorFunc: passwordValidation,
                      controller: myControllerNewPassword,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      bottom: screenheight * 0.06,
                      left: screenwidth * 0.04,
                      right: screenwidth * 0.04,
                    ),
                    child: CustomTextField(
                      key: const ValueKey(
                          SignInKeys.forgetPasswordConfirmNewPasswordFieldKey),
                      label: "Confirm your password",
                      validatorFunc: passwordValidation,
                      controller: myControllerConfirmPassword,
                    ),
                  ),
                ],
              ),
            ),
            // Align(
            //   alignment: Alignment.bottomCenter,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.end,
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       const Divider(),

            //     ],
            //   ),
            // ),
          ],
        ),
      ),
      bottomSheet: Align(
        heightFactor: screenheight * 0.0013,
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            key: const ValueKey(SignInKeys.nextButtonKey),
            color: forgroundColorTheme(context),
            text: 'Change Password',
            initialEnabled: isButtonEnabled,
            onPressedCallback: () async {
              String res = await SignInServices.resetPassword(
                  myControllerNewPassword.text);
              if (res != 'success') {
                print(myControllerNewPassword.text);
                showToastWidget(
                    CustomToast(
                      message: res,
                    ),
                    position: ToastPosition.bottom,
                    duration: const Duration(seconds: 4));
              } else {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    CustomPageRoute(
                        direction: AxisDirection.left,
                        child: const ResetPasswordMobile2()));
              }
            },
          ),
        ),
      ),
    );
  }
}
