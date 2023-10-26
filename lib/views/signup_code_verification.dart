import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class SingupCodeVerification extends StatefulWidget {
  SingupCodeVerification({super.key, required this.email});
  final String email;

  @override
  State<SingupCodeVerification> createState() => _SingupCodeVerificationState();
}

class _SingupCodeVerificationState extends State<SingupCodeVerification> {
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
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: CustomAppbar(
              iconAction: (context) {
                // Navigator.pop(context);
              },
              iconShape: Icon(
                Icons.arrow_back,
                color: forgroundColorTheme(context),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.8,
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
                        textValue: "Enter it below to verify ${widget.email} ",
                        textAlign: TextAlign.left),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: CustomTextField(
                      label: "Verification Code",
                      validatorFunc: codeValidation,
                      controller: myController,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Text('Didn\'t receive email?',
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
                Divider(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                    color: forgroundColorTheme(context),
                    text: "Next",
                    onPressedCallback: () {},
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
