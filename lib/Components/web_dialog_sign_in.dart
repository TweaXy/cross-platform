import 'package:flutter/material.dart';
import 'package:tweaxy/Components/sign_choose.dart';
import 'package:tweaxy/Components/text_and_link.dart';

class WebDialogSignIn extends StatelessWidget {
  const WebDialogSignIn({
    super.key,
    required this.dialogWidth,
    required this.isDarkMode,
  });

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
        //TODO Add Custom text field here
        //TODO Add Custom Button here
        Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: SizedBox(
            width: 350,
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
