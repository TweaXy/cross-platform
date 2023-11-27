import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/signup_service.dart';
import 'package:tweaxy/shared/keys/sign_up_keys.dart';
import 'package:tweaxy/views/signup/mobile/authentication_view.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/review_input_text_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/models/user_signup.dart';

class CreateAccountDataReview extends StatefulWidget {
  const CreateAccountDataReview({
    super.key,
  });

  @override
  State<CreateAccountDataReview> createState() =>
      _CreateAccountDataReviewState();
}

class _CreateAccountDataReviewState extends State<CreateAccountDataReview> {
  SignupService service = SignupService(Dio());
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppbar(
        key: const ValueKey("createAccountDataReviewAppbar"),
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
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    top: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomHeadText(
                        textValue: "Create your account",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .03),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: ReviewInputTextField(
                            key: const ValueKey(SignUpKeys.reviewNameFieldKey),
                            textValue: UserSignup.name,
                            label: "Name"),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .03),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: ReviewInputTextField(
                            key: const ValueKey(SignUpKeys.reviewEmailFieldKey),
                            label: "email",
                            textValue: UserSignup.email),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .03),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: ReviewInputTextField(
                            key: const ValueKey(
                                SignUpKeys.reviewBirthDateFieldKey),
                            label: "Date of Birth",
                            textValue: UserSignup.birthdayDate),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomButton(
                key: const ValueKey(SignUpKeys.signUpButtonKey),
                color: forgroundColorTheme(context),
                text: "Sign up",
                onPressedCallback: () async {
                  try {
                    dynamic response =
                        await service.sendEmailCodeVerification();
                    if (response is String) {
                      showToastWidget(
                        CustomToast(
                            message: response, screenWidth: screenWidth),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2),
                      );
                    } else if (mounted) {
                      //TODO go to home page
                      Navigator.push(
                          context,
                          CustomPageRoute(
                              direction: AxisDirection.left,
                              child: const AuthenticationView()));
                    }
                  } on Exception catch (e) {
                    log(e.toString());
                  }
                },
                initialEnabled: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
