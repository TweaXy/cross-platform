import 'package:flutter/material.dart';
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
  SingupCodeVerificationView({super.key, required this.email});
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
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: CustomAppbar(
              iconButton: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: forgroundColorTheme(context),
                ),
                onPressed: () {},
              ),
            ),
          ),
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
                    onPressedCallback: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          CustomPageRoute(
                              direction: AxisDirection.left,
                              child: AddPasswordView()));
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
