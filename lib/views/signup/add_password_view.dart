import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/add_username_view.dart';

class AddPasswordView extends StatefulWidget {
  const AddPasswordView({
    super.key,
  });

  @override
  State<AddPasswordView> createState() => _AddPasswordViewState();
}

class _AddPasswordViewState extends State<AddPasswordView> {
  TextEditingController myController = TextEditingController();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    myController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = myController.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: const CustomAppbar(
              iconButton: null,
              key: ValueKey("addPasswordAppbar"),
            ),
          ),
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
                    child: const CustomHeadText(
                      textValue: "You'll need a password",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: const CustomParagraphText(
                        textValue: "Make sure it's 8 characters or more",
                        textAlign: TextAlign.left),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: CustomTextField(
                      key: const ValueKey("addPasswordTextField"),
                      label: "Password",
                      validatorFunc: passwordValidation,
                      controller: myController,
                    ),
                  ),
                  InkWell(
                    key: const ValueKey("DidntReceiveEmail"),
                    onTap: () {},
                    child: const Text('Didn\'t receive email?',
                        style: TextStyle(
                          color: Colors.blue,
                        )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                    key: const ValueKey("addPasswordButton"),
                    color: forgroundColorTheme(context),
                    text: "Next",
                    onPressedCallback: () {
                      Navigator.pop(context);
                      Navigator.push(
                          context,
                          CustomPageRoute(
                              direction: AxisDirection.left,
                              child: AddUsernameView()));
                    },
                    initialEnabled: isButtonEnabled,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
