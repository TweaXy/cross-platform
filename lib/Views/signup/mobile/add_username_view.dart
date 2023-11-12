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
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/models/user_signup.dart';
import 'package:tweaxy/services/signup_service.dart';

class AddUsernameView extends StatefulWidget {
  const AddUsernameView({
    super.key,
  });

  @override
  State<AddUsernameView> createState() => _AddUsernameViewState();
}

class _AddUsernameViewState extends State<AddUsernameView> {
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

  final _formKey = GlobalKey<FormState>();
  SignupService service = SignupService(Dio());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: const CustomAppbar(
          key: ValueKey("addUsernameAppbar"),
          iconButton: null,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.9,
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
                          textValue: "What should we call you?",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.03),
                        child: CustomParagraphText(
                            textValue:
                                "Your @username is unique. You can always change it later.",
                            textAlign: TextAlign.left),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: Form(
                          key: _formKey,
                          child: CustomTextField(
                            key: const ValueKey("addUsernameTextField"),
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
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          key: const ValueKey("addUsernameSkipButton"),
                          color: backgroundColorTheme(context),
                          text: "Skip for now",
                          onPressedCallback: () {
                            //TODO: Use the suggestions
                            //TODO: go to home page
                          },
                          initialEnabled: true,
                        ),
                        CustomButton(
                          key: const ValueKey("addUsernameNextButton"),
                          color: forgroundColorTheme(context),
                          text: "Next",
                          onPressedCallback: () async {
                            if (_formKey.currentState!.validate()) {
                              UserSignup.username = myController.text;
                              try {
                                dynamic response =
                                    await service.createAccount();
                                log(response.toString());
                                if (response is String) {
                                  showToastWidget(
                                    CustomToast(
                                        message: response,
                                        screenWidth: screenWidth),
                                    position: ToastPosition.bottom,
                                    duration: const Duration(seconds: 2),
                                  );
                                } else if (response.statusCode == 200 &&
                                    mounted) {
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                  Navigator.pushReplacementNamed(
                                      context, kHomeScreen);
                                } else if (mounted) {
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                }
                              } on Exception catch (e) {
                                log(e.toString());
                              }
                            } else {
                              showToastWidget(
                                CustomToast(
                                    message: "Please enter a valid username.",
                                    screenWidth: screenWidth),
                                position: ToastPosition.bottom,
                                duration: const Duration(seconds: 2),
                              );
                            }
                          },
                          initialEnabled: isButtonEnabled,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
