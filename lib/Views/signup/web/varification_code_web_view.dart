import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar_web.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/web/add_password_web_view.dart';

class VarificationCodeWebView extends StatefulWidget {
  const VarificationCodeWebView({
    super.key,
    required this.email,
  });

  final String email;

  @override
  State<VarificationCodeWebView> createState() =>
      _VarificationCodeWebViewState();
}

class _VarificationCodeWebViewState extends State<VarificationCodeWebView> {
  TextEditingController varificationCodeController = TextEditingController();
  void initState() {
    super.initState();
    varificationCodeController.addListener(_updateNextButtonState);
  }

  bool _isnextButtonEnabled = false;
  void _updateNextButtonState() {
    setState(() {
      _isnextButtonEnabled = varificationCodeController.text.isNotEmpty;
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
              CustomAppbarWeb(
                key: const ValueKey("VarificarionCodeAppbar"),
                pageNumber: "3",
                icon: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: forgroundColorTheme(context),
                  ),
                  onPressed: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
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
                            textValue: "We Sent you a Code",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomParagraphText(
                              size: 15,
                              textValue:
                                  "Enter it below to verify ${widget.email} ",
                              textAlign: TextAlign.left),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: CustomTextField(
                            key: const ValueKey("VerificationCodeTextField"),
                            label: "Verification Code",
                            validatorFunc: codeValidation,
                            controller: varificationCodeController,
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: InkWell(
                            key: const ValueKey(
                                "VerificationCodeDidntReceiveEmail"),
                            onTap: () {},
                            child: const Text('Didn\'t receive email?',
                                style: TextStyle(
                                  color: Colors.blue,
                                )),
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
                  onPressedCallback: () {
                    showDialog(
                      context: context,
                      builder: (context) => const AddPasswordWebView(),
                      barrierColor: Colors.transparent,
                      barrierDismissible: false,
                    );
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
