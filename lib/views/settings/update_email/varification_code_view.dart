import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class VarificationCodeView extends StatefulWidget {
  const VarificationCodeView({super.key});

  @override
  State<VarificationCodeView> createState() => _VarificationCodeViewState();
}

class _VarificationCodeViewState extends State<VarificationCodeView> {
  TextEditingController codeController = TextEditingController();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    codeController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = codeController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
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
      body: Center(
        heightFactor: 1,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
                            textValue: "Enter it below to verify your email",
                            textAlign: TextAlign.left),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.02),
                        child: CustomTextField(
                          label: "Verification Code",
                          validatorFunc: codeValidation,
                          controller: codeController,
                        ),
                      ),
                      InkWell(
                        onTap: () async {},
                        child: const Text('Didn\'t receive email?',
                            style: TextStyle(
                              color: Colors.blue,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Divider(),
          Align(
            widthFactor: 4.8,
            alignment: Alignment.bottomRight,
            child: CustomButton(
              color: forgroundColorTheme(context),
              text: "Verify",
              onPressedCallback: () {},
              initialEnabled: isButtonEnabled,
            ),
          ),
        ],
      ),
    );
  }
}
