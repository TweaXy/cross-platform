import 'package:flutter/material.dart';
import 'package:tweaxy/Views/settings/update_email/change_email_view.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/settings/update_email_components/password_text_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class PasswordVarificationView extends StatefulWidget {
  const PasswordVarificationView({super.key});

  @override
  State<PasswordVarificationView> createState() =>
      _PasswordVarificationViewState();
}

class _PasswordVarificationViewState extends State<PasswordVarificationView> {
  TextEditingController passwordController = TextEditingController();
  bool isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty &&
          passwordController.text.replaceAll(" ", "").isNotEmpty) {
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
      body: Center(
        heightFactor: MediaQuery.of(context).size.height * 0.002,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.025),
              child: CustomHeadText(
                textValue: "Verify Your Password",
                textAlign: TextAlign.center,
                size: 36,
              ),
            ),
            CustomParagraphText(
              textValue: "Re-enter Your TweaXy Password to continue.",
              textAlign: TextAlign.center,
              size: 18,
            ),
            Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * .07,
                    vertical: MediaQuery.of(context).size.height * 0.025),
                child: PasswordTextField(
                  isButtonEnabled: isButtonEnabled,
                  passwordcontroller: passwordController,
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
                CustomButton(
                  color: backgroundColorTheme(context),
                  text: "cancel",
                  onPressedCallback: () {
                    Navigator.pop(context);
                  },
                  initialEnabled: true,
                ),
                CustomButton(
                  color: forgroundColorTheme(context),
                  text: "Next",
                  onPressedCallback: () {
                    Navigator.push(
                        context,
                        CustomPageRoute(
                            direction: AxisDirection.left,
                            child: const ChangeEmailView()));
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
