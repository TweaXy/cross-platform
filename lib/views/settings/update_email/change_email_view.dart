import 'package:flutter/material.dart';
import 'package:tweaxy/Views/settings/update_email/varification_code_view.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class ChangeEmailView extends StatefulWidget {
  const ChangeEmailView({super.key});

  @override
  State<ChangeEmailView> createState() => _ChangeEmailViewState();
}

class _ChangeEmailViewState extends State<ChangeEmailView> {
  TextEditingController emailController = TextEditingController();
  bool isButtonEnabled = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(() {
      if (emailController.text.isNotEmpty &&
          emailController.text.replaceAll(" ", "").isNotEmpty) {
        setState(() {
          isButtonEnabled = true;
        });
      } else {
        setState(() {
          isButtonEnabled = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        iconButton: IconButton(
            onPressed: () {}, icon: const Icon(Icons.hourglass_empty)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.height * 0.05),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.025),
                    child: CustomHeadText(
                      textValue: "Add an email",
                      textAlign: TextAlign.start,
                      size: 36,
                    ),
                  ),
                ),
                CustomParagraphText(
                  textValue:
                      "Enter the email address you'd like to asociate with your tweaXy account. Your email is not displayed in your public profile on tweaXy",
                  textAlign: TextAlign.start,
                  size: 18,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.025),
                    child: CustomTextField(
                      key: const ValueKey(  "old email input field "),
                      validatorFunc: emailValidation,
                      label: "Email",
                      controller: emailController,
                    )),
              ]),
        ),
      ),
      bottomSheet: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Divider(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(key: const ValueKey("old email input field cancel button"),

                  color: backgroundColorTheme(context),
                  text: "cancel",
                  onPressedCallback: () {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  },
                  initialEnabled: true,
                ),
                CustomButton(
                  key: const ValueKey("next button for old email input screen"),
                  color: forgroundColorTheme(context),
                  text: "Next",
                  onPressedCallback: () {
                    Navigator.push(
                        context,
                        CustomPageRoute(
                            direction: AxisDirection.left,
                            child: const VarificationCodeView()));
                  },
                  initialEnabled: isButtonEnabled,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
