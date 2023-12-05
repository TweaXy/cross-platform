import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/services/update_email.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class VarificationCodeView extends StatefulWidget {
  const VarificationCodeView({super.key, required this.email});
  final String email;
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
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: CustomAppbar(
        key: const ValueKey("code screen back arrow"),
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
                          key: const ValueKey("Varification code input field"),
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
              key: const ValueKey("varification code verify button"),
              color: forgroundColorTheme(context),
              text: "Verify",
              onPressedCallback: () async {
                dynamic response = UpdateEmail(Dio())
                    .changeEmail(codeController.text, widget.email);
                if (response is String) {
                  showToastWidget(
                    CustomToast(message: response, screenWidth: screenWidth),
                    position: ToastPosition.bottom,
                    duration: const Duration(seconds: 2),
                  );
                } else {
                  setState(() {
                    TempUser.email = widget.email;
                  });
                  showToastWidget(
                    CustomToast(
                        message: "email changes sucessfully",
                        screenWidth: screenWidth),
                    position: ToastPosition.bottom,
                    duration: const Duration(seconds: 2),
                  );
                  if (kDebugMode) {
                    print(response);
                  }
                  Navigator.popUntil(context, (route) => route.isFirst);
                }
              },
              initialEnabled: isButtonEnabled,
            ),
          ),
        ],
      ),
    );
  }
}
