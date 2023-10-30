import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class AddUsernameWebView extends StatelessWidget {
  const AddUsernameWebView({super.key});
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
              Container(
                padding: const EdgeInsets.only(left: 15, top: 15),
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height * 0.1,
                child: const CustomAppbar(
                  key: ValueKey("addUsernameWebAppbar"),
                  iconButton: null,
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomHeadText(
                      textValue: "What should we call you?",
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02),
                      child:  CustomParagraphText(
                          textValue:
                              "Your @username is unique. You can always change it later.",
                          textAlign: TextAlign.left),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02),
                      child: CustomTextField(
                        key: const ValueKey("addUsernameWebTextField"),
                        label: "Username",
                        validatorFunc: usernameValidation,
                        controller: TextEditingController(),
                      ),
                    ),
                    InkWell(
                      key: const ValueKey("addUsernameSuggestions"),
                      onTap: () {},
                      child: const Text(
                          'Suggestions -- Suggestions -- Suggestions',
                          style: TextStyle(
                            color: Colors.blue,
                          )),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: CustomButton(
                  key: const ValueKey("addUsernameWebSkipButton"),
                  color: backgroundColorTheme(context),
                  text: "Skip for now",
                  onPressedCallback: () {
                    //TODO handle navigation
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
