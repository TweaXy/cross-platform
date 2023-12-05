import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/signup_service.dart';
import 'package:tweaxy/shared/keys/sign_up_keys.dart';
import 'package:tweaxy/views/signup/mobile/add_profile_picture_view.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/models/user_signup.dart';

class AddPasswordView extends StatefulWidget {
  const AddPasswordView({
    super.key,
  });

  @override
  State<AddPasswordView> createState() => _AddPasswordViewState();
}

class _AddPasswordViewState extends State<AddPasswordView> {
  TextEditingController myController = TextEditingController();
  bool isButtonEnabled = false;
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

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        iconButton: null,
        key: ValueKey("addPasswordAppbar"),
      ),
      body: Center(
        heightFactor: 1,
        child: SingleChildScrollView(
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
                          textValue: "You'll need a password",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.03),
                        child: CustomParagraphText(
                            textValue: "Make sure it's 8 characters or more",
                            textAlign: TextAlign.left),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: Form(
                          key: _formKey,
                          child: CustomTextField(
                            key: const ValueKey(SignUpKeys.addPasswordFieldKey),
                            label: "Password",
                            validatorFunc: passwordValidation,
                            controller: myController,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Divider(),
          Align(
            alignment: Alignment.bottomRight,
            widthFactor: 4.8,
            child: CustomButton(
              key: const ValueKey(SignUpKeys.addPasswordNextButtonKey),
              color: forgroundColorTheme(context),
              text: "Next",
              onPressedCallback: () async {
                if (_formKey.currentState!.validate()) {
                  UserSignup.password = myController.text;
                  try {
                    dynamic response = await service.createAccount();
                    if (response is String) {
                      showToastWidget(
                        CustomToast(
                          message: response,
                        ),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2),
                      );
                    } else {
                      try {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString("id",
                            response.data['data']['user']['id'].toString());
                        prefs.setString(
                            "token", response.data['data']['token'].toString());

                        if (mounted) {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              CustomPageRoute(
                                  direction: AxisDirection.left,
                                  child: const AddProfilePictureView()));
                        }
                      } catch (e) {
                        log(e.toString());
                      }
                    }
                  } catch (e) {
                    log(e.toString());
                  }
                } else {
                  showToastWidget(
                    CustomToast(
                        message: "Please enter a valid password.",
                        screenWidth: MediaQuery.of(context).size.width),
                    position: ToastPosition.bottom,
                    duration: const Duration(seconds: 2),
                  );
                }
              },
              initialEnabled: isButtonEnabled,
            ),
          ),
        ],
      ),
    );
  }
}
