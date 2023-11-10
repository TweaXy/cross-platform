import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tweaxy/services/signup_service.dart';
import 'package:tweaxy/views/signup/mobile/authentication_view.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/review_input_text_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/models/user.dart';

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
                      child: ReviewInputTextField(
                          textValue: User.name, label: "Name"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .03),
                      child: ReviewInputTextField(
                          label: "email", textValue: User.email),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * .03),
                      child: ReviewInputTextField(
                          label: "Date of Birth", textValue: User.birthdayDate),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: CustomButton(
                key: const ValueKey("CreateAccountSignupButton"),
                color: forgroundColorTheme(context),
                text: "Sign up",
                onPressedCallback: () async {
                  dynamic response = await service.sendEmailCodeVerification();
                  if (response.statusCode == 200) {
                    //TODO go to home page
                    Navigator.push(
                        context,
                        CustomPageRoute(
                            direction: AxisDirection.left,
                            child: const AuthenticationView()));
                  } else {
                    Fluttertoast.showToast(
                        msg: response.data['message'],
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
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
