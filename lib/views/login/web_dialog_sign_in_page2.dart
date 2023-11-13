import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_dialog_app_bar.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/text_and_link.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/services/login_api.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

// ignore: must_be_immutable
class WebDialogSignInPage2 extends StatefulWidget {
  WebDialogSignInPage2(
      {super.key, required this.isDarkMode, required this.myControll});
  final TextEditingController myControll;
  final bool isDarkMode;

  @override
  State<WebDialogSignInPage2> createState() => _WebDialogSignInPage2State();
}

class _WebDialogSignInPage2State extends State<WebDialogSignInPage2> {
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
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.light;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomDialogAppBar(isDarkMode: isDarkMode),
          const Padding(
            padding: EdgeInsets.only(left: 60, top: 30),
            child: Row(
              children: [
                Text(
                  'Enter your password',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            width: 500,
            child: TextField(
              style: TextStyle(
                color:
                    widget.isDarkMode ? Color(0xffADB5BC) : Color(0xff292b2d),
              ),
              controller: widget.myControll,
              enabled: false,
              decoration: InputDecoration(
                labelText: 'Username',
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                filled: true,
                fillColor: !widget.isDarkMode
                    ? Color(0xff101214)
                    : Color(0xfff7f9f9), // Specify the background color
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 25.0, horizontal: 20.0),
                border: OutlineInputBorder(),
                disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2, color: backgroundColorTheme(context))),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: SizedBox(
              width: 500,
              height: 90,
              child: CustomTextField(
                  key: const ValueKey(passwordTextFieldKey),
                  label: 'Password',
                  validatorFunc: passwordValidation,
                  controller: myControllerPassword),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 12.0),
                    child: SizedBox(
                        width: 500,
                        height: 50,
                        child: CustomButton(
                            color: forgroundColorTheme(context),
                            key: const ValueKey(logInView2NextButtonKey),
                            text: 'Login',
                            onPressedCallback: () async {
                              try {
                                Map<String, dynamic> user = await LoginApi()
                                    .postUser({
                                  'UUID': '${widget.myControll.text}',
                                  'password': '${myControllerPassword.text}'
                                }) as Map<String, dynamic>;
                                //go to home page
                                print(user);
                                // ignore: use_build_context_synchronously
                                Navigator.pushNamed(context, kHomeScreen);
                              } on DioException catch (e) {
                                print('DioException: ${e.toString()}');
                                // ignore: use_build_context_synchronously
                                // showSnackBar(context, e.response!.data['message']);
                                showToastWidget(
                                  CustomWebToast(
                                    message: e.response!.data['message'],
                                  ),
                                  position: ToastPosition.bottom,
                                  duration: const Duration(seconds: 2),
                                );
                              } on Exception catch (e) {
                                print(e.toString());
                                showToastWidget(
                                  CustomWebToast(
                                    message: e.toString(),
                                  ),
                                  position: ToastPosition.bottom,
                                  duration: const Duration(seconds: 2),
                                );
                                // ignore: use_build_context_synchronously
                                // showSnackBar(context, e);
                              }
                            },
                            initialEnabled: isButtonEnabled)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: TextAndLink(
                      text: 'Don\'t have an account? ',
                      linkedText: 'Sign up',
                      onPressed: () {},
                      linkKey: const ValueKey('webMainDialogDntHaveAccount'),
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
