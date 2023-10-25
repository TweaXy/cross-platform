import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/constants/custom_text_form_validations.dart';
import 'package:tweaxy/views/forget_password_page2.dart';
import 'package:tweaxy/views/login_view_page2.dart';

class ForgetPasswordPage3 extends StatefulWidget {
  const ForgetPasswordPage3({super.key});

  @override
  State<ForgetPasswordPage3> createState() => _LoginViewPage1State();
}

class _LoginViewPage1State extends State<ForgetPasswordPage3> {
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
                  'We sent you a code',
                  overflow: TextOverflow.clip,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 15, right: 15),
            child: Text(
              'Check your phone to get your confirmation code. if you need to requst a new code, go back and reselect a confimation method.',
              overflow: TextOverflow.fade,
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                  color: Colors.black54),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomTextField(
              validatorFunc: emailValidation,
              label: 'Enter your code',
              controller: myController,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Divider(
                  color: Colors.black26,
                  height: 0.5,
                  thickness: 1,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        color: Colors.white,
                        text: 'Back',
                        initialEnabled: true,
                        onPressedCallback: () {
                          // Navigator.pop(context);
                          // Navigator.push(
                          //     context,
                          //     CustomPageRoute(
                          //         direction: AxisDirection.left,
                          //         child: ()));
                        },
                      ),
                      CustomButton(
                        color: Colors.black,
                        text: 'Next',
                        initialEnabled: isButtonEnabled,
                        onPressedCallback: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              CustomPageRoute(
                                  direction: AxisDirection.left,
                                  child: LoginViewPage2(
                                    initialValue: myController,
                                  )));
                        },
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }
}
