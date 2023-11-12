import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/models/users.dart';
import 'package:tweaxy/services/login_api.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/snackbar.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/login/forget_password_page1.dart';

// ignore: must_be_immutable
class LoginViewPage2 extends StatefulWidget {
  final TextEditingController initialValue;
  LoginViewPage2({super.key, required this.initialValue});

  @override
  State<LoginViewPage2> createState() => _LoginViewPage2State();
}

class _LoginViewPage2State extends State<LoginViewPage2> {
  TextEditingController myControllerPassword = TextEditingController();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    myControllerPassword.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      isButtonEnabled = myControllerPassword.text.isNotEmpty;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(
        iconButton: IconButton(
          key: const ValueKey("loginView2BackIcon"),
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
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Enter your password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
              ),
              // Other widgets...
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              style: TextStyle(
                color: isDarkMode ? Color(0xffADB5BC) : Color(0xff292b2d),
              ),
              controller: widget.initialValue,
              enabled: false,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 20.0),
                border: const OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: !isDarkMode ? Colors.black87 : Colors.white10)),
              ),
            ),
          ),
          SizedBox(
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: CustomTextField(
              key: const ValueKey("loginView2TextField"),
              validatorFunc: passwordValidation,
              label: 'Password',
              controller: myControllerPassword,
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
                        key: const ValueKey("loginView2ForgetPassButton"),
                        color: backgroundColorTheme(context),
                        text: 'Forget password?',
                        initialEnabled: true,
                        onPressedCallback: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              CustomPageRoute(
                                  direction: AxisDirection.left,
                                  child: ForgetPasswordPage1()));
                        },
                      ),
                      CustomButton(
                        key: const ValueKey("loginView2NextButton"),
                        color: forgroundColorTheme(context),
                        text: 'Log in',
                        initialEnabled: isButtonEnabled,
                        onPressedCallback: () async {
                          try {
                            Map<String, dynamic> user =
                                await LoginApi().postUser({
                              'UUID': '${widget.initialValue.text}',
                              'password': '${myControllerPassword.text}'
                            }) as Map<String, dynamic>;
                            //go to home page
                            print(user);
                            
                            Navigator.pushNamed(context, 
                            kHomeScreen);
                          } on DioException catch (e) {
                            print(e.toString());
                            // ignore: use_build_context_synchronously
                            // showSnackBar(context, e.response!.data['message']);
                            showToastWidget(
                              CustomToast(
                                  message: e.response!.data['message'],
                                  screenWidth: screenWidth),
                              position: ToastPosition.bottom,
                              duration: const Duration(seconds: 2),
                            );
                          } on Exception catch (e) {
                            // ignore: use_build_context_synchronously
                            // showSnackBar(context, e);
                            showToastWidget(
                              CustomToast(
                                  message: e.toString(),
                                  screenWidth: screenWidth),
                              position: ToastPosition.bottom,
                              duration: const Duration(seconds: 2),
                            );
                          }
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