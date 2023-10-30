import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/views/login/forget_password_page2.dart';
import 'package:tweaxy/views/login/forget_password_page3.dart';
import 'package:tweaxy/views/login/login_view_page2.dart';

class ForgetPasswordPage1 extends StatefulWidget {
  const ForgetPasswordPage1({super.key});

  @override
  State<ForgetPasswordPage1> createState() => _LoginViewPage1State();
}

class _LoginViewPage1State extends State<ForgetPasswordPage1> {
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        flexibleSpace: Center(
          child: SafeArea(
            child: Image.asset(
              alignment: Alignment.center,
              'assets/images/logo-black.png', // Replace with the path to your image
              height: 25,
            ),
          ),
        ),
        leading: IconButton(
          key: const ValueKey("forgetPassView1BackIcon"),
          icon: Icon(
            Icons.close_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15.0),
                child: Text(
                  'Find your X account',
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
            child: Text(
              'Enter the email, phone number or username associated with your account to change your password',
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black45),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomTextField(
              key: const ValueKey("forgetPassView1TextField"),
              validatorFunc: emailValidation,
              label: 'Phone, email address, username',
              controller: myController,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomButton(
                      key: const ValueKey("forgetPassView1NextButton"),
                      color: Colors.black,
                      text: 'Next',
                      initialEnabled: isButtonEnabled,
                      onPressedCallback: () {
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            CustomPageRoute(
                                direction: AxisDirection.left,
                                child: ForgetPasswordPage3()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
