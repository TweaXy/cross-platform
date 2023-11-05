import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_dialog_app_bar.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class ForgetPasswordWeb3 extends StatelessWidget {
  const ForgetPasswordWeb3({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController myController = TextEditingController();
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return SizedBox(
        height: MediaQuery.of(context).size.height * 0.9,
        width: MediaQuery.of(context).size.width * 0.4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomDialogAppBar(isDarkMode: !isDarkMode),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'We sent you a code',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
                child: Text(
                  'Check your phone to get your confirmation code. if you need to requst a new code, go back and reselect a confimation method.',
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 20,
                    color: !isDarkMode ? Colors.black87 : Colors.white38,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: CustomTextField(
                  key: const ValueKey("forgetPassView3TextField"),
                  validatorFunc: emailValidation,
                  label: 'Enter your code',
                  controller: myController,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 50,
                          width: 350,
                          child: CustomButton(
                            key: const ValueKey("forgetPassView3BackButton"),
                            color: backgroundColorTheme(context),
                            text: 'Back',
                            initialEnabled: true,
                            onPressedCallback: () {
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      ]),
                ),
              )
            ],
          ),
        ));
  }
}