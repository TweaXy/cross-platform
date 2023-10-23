import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/views/login_view_page2.dart';

class LoginViewPage1 extends StatefulWidget {
  const LoginViewPage1({super.key});

  @override
  State<LoginViewPage1> createState() => _LoginViewPage1State();
}

class _LoginViewPage1State extends State<LoginViewPage1> {
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
          child: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Image.asset(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(
              'To get started, first enter your phone, email address or @username',
              overflow: TextOverflow.clip,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomTextField(
              label: 'Phone, email address, username',
              controller: myController,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                Container(
                  color: Colors.black26,
                  height: 0.5,
                  width: double.infinity,
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        color: Colors.white,
                        text: 'Forget password?',
                        initialEnabled: true,
                        onPressedCallback: () {},
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
