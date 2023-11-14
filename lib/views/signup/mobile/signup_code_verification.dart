import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/services/signup_service.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/mobile/add_password_view.dart';
import 'package:tweaxy/models/user_signup.dart';
import 'package:tweaxy/shared/keys/sign_up_keys.dart';

class SingupCodeVerificationView extends StatefulWidget {
  const SingupCodeVerificationView({super.key});

  @override
  State<SingupCodeVerificationView> createState() =>
      _SingupCodeVerificationViewState();
}

class _SingupCodeVerificationViewState
    extends State<SingupCodeVerificationView> {
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

  SignupService service = SignupService(Dio());

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: CustomAppbar(
          key: const ValueKey("SingupCodeVerificationAppbar"),
          iconButton: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: forgroundColorTheme(context),
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
                width: screenWidth * 0.9,
                height: MediaQuery.of(context).size.height * 0.78,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: MediaQuery.of(context).size.height * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.01),
                        child: CustomHeadText(
                          textValue: "We sent you a code",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.03),
                        child: CustomParagraphText(
                            textValue:
                                "Enter it below to verify ${UserSignup.email} ",
                            textAlign: TextAlign.left),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: CustomTextField(
                          key: const ValueKey(
                              SignUpKeys.verificationCodeFieldKey),
                          label: "Verification Code",
                          validatorFunc: codeValidation,
                          controller: myController,
                        ),
                      ),
                      InkWell(
                        key: const ValueKey(
                            "SingupCodeVerificationDidntReceiveEmail"),
                        onTap: () async {
                          try {
                            dynamic response =
                                await service.sendEmailCodeVerification();

                            showToastWidget(
                              CustomToast(
                                  message: response is String
                                      ? response
                                      : "Email has been resent successfully",
                                  screenWidth: screenWidth),
                              position: ToastPosition.bottom,
                              duration: const Duration(seconds: 2),
                            );
                          } catch (e) {
                            log(e.toString());
                            showToastWidget(
                                CustomToast(
                                    message: e.toString(),
                                    screenWidth: screenWidth),
                                position: ToastPosition.bottom,
                                duration: const Duration(seconds: 2));
                          }
                        },
                        child: const Text('Didn\'t receive email?',
                            style: TextStyle(
                              color: Colors.blue,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Divider(),
                    Align(
                      widthFactor: 4.8,
                      alignment: Alignment.bottomRight,
                      child: CustomButton(
                        key: const ValueKey(
                            SignUpKeys.verificationNextButtonKey),
                        color: forgroundColorTheme(context),
                        text: "Next",
                        onPressedCallback: () async {
                          try {
                            dynamic response = await SignupService(Dio())
                                .checkEmailCodeVerification(
                                    code: myController.text);

                            if (response is String) {
                              showToastWidget(
                                CustomToast(
                                    message: response,
                                    screenWidth: screenWidth),
                                position: ToastPosition.bottom,
                                duration: const Duration(seconds: 2),
                              );
                            } else if (mounted) {
                              UserSignup.emailVerificationToken =
                                  myController.text;
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  CustomPageRoute(
                                      direction: AxisDirection.left,
                                      child: const AddPasswordView()));
                            }
                          } catch (e) {
                            log(e.toString());
                            return "Code Uniqueness Api error ";
                          }
                        },
                        initialEnabled: isButtonEnabled,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
