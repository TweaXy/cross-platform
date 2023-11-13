import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_dialog_app_bar.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/components/sign_choose.dart';
import 'package:tweaxy/components/text_and_link.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/services/login_api.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/login/forget_passwoed_web_1.dart';
import 'package:tweaxy/views/login/web_dialog_sign_in_page2.dart';

// ignore: must_be_immutable
class WebDialogSignIn extends StatelessWidget {
  WebDialogSignIn({
    super.key,
    required this.dialogWidth,
    required this.isDarkMode,
  });
  TextEditingController myControll = TextEditingController();
  final double dialogWidth;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: CustomDialogAppBar(isDarkMode: isDarkMode),
          ),
          const Spacer(
            flex: 2,
          ),
          SizedBox(
            width: dialogWidth * 3 / 5,
            child: SignChoose(isDarkMode: !isDarkMode),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            child: CustomTextField(
                key: const ValueKey(emailTextFieldKey),
                label: 'Phone, email, or username',
                validatorFunc: () {},
                controller: myControll),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SizedBox(
                width: 300,
                height: 40,
                child: CustomButton(
                    color: forgroundColorTheme(context),
                    key: const ValueKey(logInView1NextButtonKey),
                    text: 'Next',
                    onPressedCallback: () async {
                      try {
                        Map<String, dynamic> check = await LoginApi()
                            .getEmailExist({"UUID": myControll.text});
                        if (check['status'] == "success") {
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                          // ignore: use_build_context_synchronously
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: WebDialogSignInPage2(
                                isDarkMode: isDarkMode,
                                myControll: myControll,
                              ),
                            ),
                            barrierColor:
                                const Color.fromARGB(100, 97, 119, 129),
                            barrierDismissible: false,
                          );
                        }
                      } on DioException catch (e) {
                        print('DioException: ${e.toString()}');
                        // ignore: use_build_context_synchronously
                        // showSnackBar(context, e.response!.data['message']);
                        showToastWidget(
                          CustomWebToast(
                            message: e.response!.data['message'],
                          ),
                          position: ToastPosition.bottom,
                          duration: const Duration(seconds: 10),
                        );
                      } on Exception catch (e) {
                        print(e.toString());
                        showToastWidget(
                          CustomWebToast(
                            message: e.toString(),
                          ),
                          position: ToastPosition.bottom,
                          duration: const Duration(seconds: 10),
                        );
                        // ignore: use_build_context_synchronously
                        // showSnackBar(context, e);
                      }
                    },
                    initialEnabled: true)),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: SizedBox(
              width: 300,
              height: 40,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.pop(context);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: ForgetPasswordWeb1(),
                    ),
                    barrierColor: const Color.fromARGB(100, 97, 119, 129),
                    barrierDismissible: false,
                  );
                },
                style: ButtonStyle(
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                child: Text(
                  'Forget Password?',
                  style: TextStyle(
                      color: !isDarkMode ? Colors.white : Colors.black),
                ),
              ),
            ),
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
          ),
          const Spacer(
            flex: 3,
          ),
        ],
      ),
    );
  }
}
