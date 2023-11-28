import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/views/signup/web/add_profile_picture_web_view.dart';
import 'package:tweaxy/components/custom_appbar_web.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/models/user_signup.dart';
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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    myController.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled =
          myController.text.isNotEmpty & (myController.text.length >= 8);
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
              const CustomAppbarWeb(
                key: ValueKey("CreateAccountWebAppbar"),
                pageNumber: "4",
                icon: null,
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
                    Form(
                      key: _formKey,
                      child: CustomTextField(
                        key: const ValueKey("addPasswordWebTextField"),
                        label: "Password",
                        validatorFunc: passwordValidation,
                        controller: myController,
                      ),
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
                    if (_formKey.currentState!.validate()) {
                      UserSignup.password = myController.text;
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacementNamed(context, kHomeScreen);
                      showDialog(
                        context: context,
                        builder: (context) => const AddProfilePictureWebView(),
                        barrierColor: Colors.transparent,
                        barrierDismissible: false,
                      );
                    } else {
                      showToastWidget(
                        const CustomWebToast(
                          message: "Please enter a valid password.",
                        ),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2),
                      );
                    }
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
