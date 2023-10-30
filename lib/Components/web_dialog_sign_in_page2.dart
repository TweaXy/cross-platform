import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/sign_choose.dart';
import 'package:tweaxy/components/text_and_link.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';

// ignore: must_be_immutable
class WebDialogSignInPage2 extends StatefulWidget {
  WebDialogSignInPage2(
      {super.key,
      required this.dialogWidth,
      required this.isDarkMode,
      required this.myControll});
  final TextEditingController myControll;
  final double dialogWidth;
  final bool isDarkMode;

  @override
  State<WebDialogSignInPage2> createState() => _WebDialogSignInPage2State();
}

class _WebDialogSignInPage2State extends State<WebDialogSignInPage2> {
  TextEditingController myControllerPassword = TextEditingController();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    myControllerPassword.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = myControllerPassword.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.dialogWidth * 3 / 5,
        ),
        Row(
          children: [
            Text(
              'Enter your password',
              style: TextStyle(fontFamily: 'Roberto'),
            ),
          ],
        ),
        SizedBox(
          height: 30,
        ),
        TextField(
          style: const TextStyle(
            color: Color(0xff292b2d),
          ),
          controller: widget.myControll,
          enabled: false,
          decoration: const InputDecoration(
            labelText: 'Username',
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            filled: true,
            fillColor: Color(0xff101214), // Specify the background color
            contentPadding:
                EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
            border: OutlineInputBorder(),
            disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: Colors.black)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: SizedBox(
            width: 500,
            height: 70,
            child: CustomTextField(
                label: 'Password',
                validatorFunc: passwordValidation,
                controller: myControllerPassword),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: SizedBox(
                      width: 300,
                      height: 40,
                      child: CustomButton(
                          color: Colors.white,
                          text: 'Login',
                          onPressedCallback: () {
                            // return WebDialogSignInPage2(); // Replace with the actual widget for the second screen
                          },
                          initialEnabled: isButtonEnabled)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: TextAndLink(
                    text: 'Don\'t have an account? ',
                    linkedText: 'Sign up',
                    onPressed: () {},
                    linkKey: const ValueKey('webMainDialogDntHaveAccount'),
                    fontSize: 16,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
