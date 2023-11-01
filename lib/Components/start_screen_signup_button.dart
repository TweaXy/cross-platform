import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:tweaxy/views/signup/create_account_web_view.dart';
import 'package:tweaxy/constants.dart';

class StartScreenSignupButton extends StatelessWidget {
  const StartScreenSignupButton({
    super.key,
    required this.isDarkMode,
  });

  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        width: double.infinity,
        height: 45,
        child: ElevatedButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => CreateAccountWebView(),
              barrierColor: const Color.fromARGB(100, 97, 119, 129),
              barrierDismissible: false,
            );
            // Navigator.pushNamed(context, kCreateAcountWebScreen);
          },
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(kIsWeb
                  ? Colors.lightBlue
                  : isDarkMode
                      ? Colors.white
                      : Colors.black),
              shape: const MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(50),
                  ),
                ),
              )),
          child: Text(
            'Create Account',
            style: TextStyle(
              color: kIsWeb
                  ? Colors.white
                  : !isDarkMode
                      ? Colors.white
                      : Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
