import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/toasts/custom_toast.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/services/login_api.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/snackbar.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/login/forget_password_page1.dart';
import 'package:tweaxy/views/login/login_view_page2.dart';

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
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomAppbar(
        iconButton: IconButton(
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
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04,
                vertical: MediaQuery.of(context).size.height * 0.03),
            child: Text(
              'To get started, first enter your phone, email address or @username',
              overflow: TextOverflow.clip,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.01,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.04),
            child: CustomTextField(
              key: const ValueKey(SignInKeys.emailFieldKey),
              validatorFunc: () {},
              label: 'Phone, email, or username',
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
                  height: MediaQuery.of(context).size.height * 0.01,
                  thickness: 1,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.03,
                      vertical: MediaQuery.of(context).size.height * 0.015),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomButton(
                        key: const ValueKey(SignInKeys.forgetPasswordButtonKey),
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
                        key: const ValueKey(SignInKeys.nextButtonKey),
                        color: forgroundColorTheme(context),
                        text: 'Next',
                        initialEnabled: isButtonEnabled,
                        onPressedCallback: () async {
                          try {
                            Map<String, dynamic> check = await LoginApi()
                                .getEmailExist({"UUID": myController.text});
                            if (check['status'] == "success") {
                              // ignore: use_build_context_synchronously
                              Navigator.pop(context);
                              // ignore: use_build_context_synchronously
                              Navigator.push(
                                context,
                                CustomPageRoute(
                                  direction: AxisDirection.left,
                                  child: LoginViewPage2(
                                    initialValue: myController,
                                  ),
                                ),
                              );
                            }
                          } on DioException catch (e) {
                            //   print(e.toString());
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
