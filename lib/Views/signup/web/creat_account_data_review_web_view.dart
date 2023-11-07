import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar_web.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/review_input_text_field.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/web/varification_code_web_view.dart';

class CreateAccountDataReviewWebView extends StatefulWidget {
  const CreateAccountDataReviewWebView(
      {super.key,
      required this.dateOfBirth,
      required this.email,
      required this.name});
  final String name;
  final String email;
  final String dateOfBirth;
  @override
  State<CreateAccountDataReviewWebView> createState() =>
      _CreateAccountDataReviewWebViewState();
}

class _CreateAccountDataReviewWebViewState
    extends State<CreateAccountDataReviewWebView> {
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
              CustomAppbarWeb(
                key: const ValueKey("CreateAccountReviewWebAppbar"),
                pageNumber: "2",
                icon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: forgroundColorTheme(context),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.38,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.025,
                      top: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.width * 0.025),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                              top: MediaQuery.of(context).size.height * 0.05),
                          child: ReviewInputTextField(
                              textValue: widget.name, label: "Name"),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05),
                          child: ReviewInputTextField(
                              label: "email", textValue: widget.email),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.05),
                          child: ReviewInputTextField(
                              label: "Date of Birth",
                              textValue: widget.dateOfBirth),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: CustomButton(
                  key: const ValueKey("AccountReviewDataSignupButton"),
                  color: forgroundColorTheme(context),
                  text: "Sign up",
                  onPressedCallback: () {
                    showDialog(
                      context: context,
                      builder: (context) =>
                          VarificationCodeWebView(email: widget.email),
                      barrierColor: Colors.transparent,
                      barrierDismissible: false,
                    );
                  },
                  initialEnabled: true,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
