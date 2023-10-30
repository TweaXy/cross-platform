import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/sign_choose.dart';
import 'package:tweaxy/components/text_and_link.dart';
import 'package:tweaxy/components/web_dialog_sign_in_page2.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';

class WebDialogSignIn extends StatelessWidget {
  WebDialogSignIn({
    super.key,
    required this.dialogWidth,
    required this.isDarkMode,
  });
  TextEditingController myControll = TextEditingController();
  final double dialogWidth;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: dialogWidth * 3 / 5,
          child: SignChoose(isDarkMode: isDarkMode),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
          child: CustomTextField(
              label: 'Phone, email, or username',
              validatorFunc: emailValidation,
              controller: myControll),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
              width: 300,
              height: 40,
              child: CustomButton(
                  color: Colors.white,
                  text: 'Next',
                  onPressedCallback: () {
                    Navigator.pop(context);
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: WebDialogSignInPage2(
                          dialogWidth: dialogWidth,
                          isDarkMode: isDarkMode,
                          myControll: myControll,
                        ),
                      ),
                      barrierColor: const Color.fromARGB(100, 97, 119, 129),
                      barrierDismissible: false,
                    );
                  },
                  initialEnabled: true)),
        ),
        //TODO Add Custom text field here
        //TODO Add Custom Button here
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            width: 300,
            height: 40,
            child: OutlinedButton(
              onPressed: () {},
              style: ButtonStyle(
                shape: MaterialStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              child: Text(
                'Forget Password?',
                style:
                    TextStyle(color: isDarkMode ? Colors.white : Colors.blue),
              ),
            ),
          ),
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
    );
  }
}
