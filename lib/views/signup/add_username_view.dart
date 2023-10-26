import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/add_profile_picture_view.dart';

class AddUsernameView extends StatefulWidget {
  AddUsernameView({
    super.key,
  });

  @override
  State<AddUsernameView> createState() => _AddUsernameViewState();
}

class _AddUsernameViewState extends State<AddUsernameView> {
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
                      textValue: "What should we call you?",
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.03),
                    child: const CustomParagraphText(
                        textValue:
                            "Your @username is unique. You can always change it later.",
                        textAlign: TextAlign.left),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.height * 0.02),
                    child: CustomTextField(
                      label: "Username",
                      validatorFunc: usernameValidation,
                      controller: myController,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child:
                        const Text('Suggestions -- Suggestions -- Suggestions',
                            style: TextStyle(
                              color: Colors.blue,
                            )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomButton(
                      color: backgroundColorTheme(context),
                      text: "Skip for now",
                      onPressedCallback: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            CustomPageRoute(
                                direction: AxisDirection.left,
                                child: AddProfilePictureView()));
                      },
                      initialEnabled: true,
                    ),
                    CustomButton(
                      color: forgroundColorTheme(context),
                      text: "Next",
                      onPressedCallback: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            CustomPageRoute(
                                direction: AxisDirection.left,
                                child: AddProfilePictureView()));
                      },
                      initialEnabled: isButtonEnabled,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
