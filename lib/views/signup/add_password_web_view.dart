import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class AddPasswordWebView extends StatefulWidget {
  const AddPasswordWebView({super.key});

  @override
  State<AddPasswordWebView> createState() => _AddPasswordWebViewState();
}

class _AddPasswordWebViewState extends State<AddPasswordWebView> {
  TextEditingController myController = TextEditingController();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    myController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = myController.text.isNotEmpty&(myController.text.length>=8);
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
              Container(
                padding: const EdgeInsets.only(left: 15, top: 15),
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height * 0.1,
                child: Text(
                  "Step 5 of 5",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      color: forgroundColorTheme(context),
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     CustomHeadText(
                      textValue: "You'll need a password",
                      textAlign: TextAlign.left,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02),
                      child: CustomParagraphText(
                          textValue: "Make sure it's 8 characters or more",
                          textAlign: TextAlign.left),
                    ),
                    CustomTextField(
                      key: const ValueKey("addPasswordWebTextField"),
                      label: "Password",
                      validatorFunc: passwordValidation,
                      controller: myController,
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: CustomButton(
                  key: const ValueKey("addPasswordWebButton"),
                  color: forgroundColorTheme(context),
                  text: "Next",
                  onPressedCallback: () {
                    //TODO handle navigation
                  },
                  initialEnabled: isButtonEnabled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
