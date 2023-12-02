import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_dialog_app_bar.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class VarificationCodeWeb extends StatefulWidget {
  const VarificationCodeWeb({super.key});

  @override
  State<VarificationCodeWeb> createState() => _VarificationCodeWebState();
}

class _VarificationCodeWebState extends State<VarificationCodeWeb> {
  TextEditingController varificationCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    varificationCodeController.addListener(_updateNextButtonState);
  }

  bool _isnextButtonEnabled = false;
  void _updateNextButtonState() {
    setState(() {
      _isnextButtonEnabled = varificationCodeController.text.isNotEmpty;
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
              CustomDialogAppBar(
                isDarkMode: true,
                icon: Icons.arrow_back,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.38,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.025,
                      top: MediaQuery.of(context).size.height * 0.02,
                      right: MediaQuery.of(context).size.width * 0.025),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: CustomHeadText(
                            textValue: "We sent you a code",
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .02),
                          child: CustomParagraphText(
                            textValue: "Enter it below to verify your email",
                            textAlign: TextAlign.start,
                            size: 15,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.03,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.02),
                          child: CustomTextField(
                            label: "Varification code",
                            validatorFunc: codeValidation,
                            controller: varificationCodeController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: CustomButton(
                  color: forgroundColorTheme(context),
                  text: "Verify",
                  onPressedCallback: () {
                    
                  },
                  initialEnabled: _isnextButtonEnabled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
