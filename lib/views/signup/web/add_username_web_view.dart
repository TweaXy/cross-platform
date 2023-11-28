import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/user_signup.dart';
import 'package:tweaxy/services/signup_service.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class AddUsernameWebView extends StatefulWidget {
  const AddUsernameWebView({super.key});

  @override
  State<AddUsernameWebView> createState() => _AddUsernameWebViewState();
}

class _AddUsernameWebViewState extends State<AddUsernameWebView> {
  TextEditingController myController = TextEditingController();
  bool isButtonEnabled = false;
  final _formKey = GlobalKey<FormState>();
  SignupService service = SignupService(Dio());

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
    return Dialog(
      backgroundColor: backgroundColorTheme(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 15, top: 15),
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height * 0.1,
                child: const CustomAppbar(
                  key: ValueKey("addUsernameWebAppbar"),
                  iconButton: null,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomHeadText(
                      textValue: "What should we call you?",
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02),
                      child: CustomParagraphText(
                          textValue:
                              "Your @username is unique. You can always change it later.",
                          textAlign: TextAlign.left),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02),
                      child: Form(
                        key: _formKey,
                        child: CustomTextField(
                          key: const ValueKey("addUsernameWebTextField"),
                          label: "Username",
                          validatorFunc: usernameValidation,
                          controller: myController,
                        ),
                      ),
                    ),
                    InkWell(
                      key: const ValueKey("addUsernameSuggestions"),
                      onTap: () {},
                      child: const Text(
                          'Suggestions -- Suggestions -- Suggestions',
                          style: TextStyle(
                            color: Colors.blue,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: _formKey.currentState == null ||
                          !isButtonEnabled ||
                          !_formKey.currentState!.validate()
                      ? CustomButton(
                          key: const ValueKey("addUsernameWebSkipButton"),
                          color: backgroundColorTheme(context),
                          text: "Skip for now",
                          onPressedCallback: () {
                            //TODO use suggestions
                            //TODO handle navigation
                          },
                          initialEnabled: true,
                        )
                      : CustomButton(
                          key: const ValueKey("addUsernameWebNextButton"),
                          color: forgroundColorTheme(context),
                          text: "Next",
                          onPressedCallback: () async {
                            UserSignup.username = myController.text;
                            try {
                              dynamic response = await service.createAccount();

                              if (response is String) {
                                log(response);
                                showToastWidget(
                                  CustomWebToast(
                                    message: response,
                                  ),
                                  position: ToastPosition.bottom,
                                  duration: const Duration(seconds: 2),
                                );
                              } else {
                                SharedPreferences prefs =
                                    await SharedPreferences.getInstance();
                                prefs.setString(
                                    "id", response["data"]["user"]["id"]);
                                prefs.setString(
                                    "token", response["data"]["token"]);
                                if (mounted) {
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  Navigator.pushReplacementNamed(
                                      context, kHomeScreen);
                                }
                              }
                            } catch (e) {
                              log(e.toString());
                            }
                          },
                          initialEnabled: true,
                        )),
            ],
          ),
        ),
      ),
    );
  }
}
