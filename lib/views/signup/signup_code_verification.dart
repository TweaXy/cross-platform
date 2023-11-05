import 'package:flutter/material.dart';
import 'package:tweaxy/views/signup/add_password_web_view.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/add_password_view.dart';

class SingupCodeVerificationView extends StatefulWidget {
  const SingupCodeVerificationView({super.key, required this.email});
  final String email;

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

  @override
  Widget build(BuildContext context) {
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
                          textValue: "We sent you a code",
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.03),
                        child: CustomParagraphText(
                            textValue:
                                "Enter it below to verify ${widget.email} ",
                            textAlign: TextAlign.left),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: CustomTextField(
                          key:
                              const ValueKey("SingupCodeVerificationTextField"),
                          label: "Verification Code",
                          validatorFunc: codeValidation,
                          controller: myController,
                        ),
                      ),
                      InkWell(
                        key: const ValueKey(
                            "SingupCodeVerificationDidntReceiveEmail"),
                        onTap: () {},
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
                        key: const ValueKey("SingupCodeVerificationNextButton"),
                        color: forgroundColorTheme(context),
                        text: "Next",
                        onPressedCallback: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              CustomPageRoute(
                                  direction: AxisDirection.left,
                                  child: const AddPasswordView()));
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
