import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/check_password_correctness.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/settings/web/new_email_dailog.dart';

class DialogVerifyPassword extends StatefulWidget {
  const DialogVerifyPassword({super.key});

  @override
  State<DialogVerifyPassword> createState() => _DialogVerifyPasswordState();
}

class _DialogVerifyPasswordState extends State<DialogVerifyPassword> {
  TextEditingController passwordVarificationController =
      TextEditingController();

  @override
  void initState() {
    super.initState();
    passwordVarificationController.addListener(_updateNextButtonState);
  }

  bool _isnextButtonEnabled = false;
  void _updateNextButtonState() {
    setState(() {
      _isnextButtonEnabled = passwordVarificationController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
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
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.08,
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/logo.svg',
                    alignment: Alignment.center,
                  ),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomHeadText(
                            textValue: "Verify your password",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .01),
                          child: CustomParagraphText(
                            textValue:
                                "Re-enter Your TweaXy Password to continue.",
                            textAlign: TextAlign.start,
                            size: 18,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: CustomTextField(
                            label: "Password",
                            validatorFunc: () {},
                            controller: passwordVarificationController,
                          ),
                        ),
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
                  text: "Next",
                  onPressedCallback: () async {
                    CheckPassword service = CheckPassword(Dio());
                    dynamic response = await service.checkPasswordCorrectness(
                        passwordVarificationController.text);
                    if (response is String) {
                      showToastWidget(
                        CustomToast(
                            message: "Wrong Password!", screenWidth: width),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2),
                      );
                    } else if (mounted) {
                      showDialog(
                        context: context,
                        builder: (context) => const NewEmailDailog(),
                        barrierColor: Colors.transparent,
                        barrierDismissible: false,
                      );
                    }
                  },
                  initialEnabled: _isnextButtonEnabled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
