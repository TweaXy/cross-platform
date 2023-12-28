import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/login/forget_password_page3.dart';

class ForgetPasswordPage2 extends StatelessWidget {
  const ForgetPasswordPage2({super.key});

  @override
  Widget build(BuildContext context) {
    bool isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      appBar: CustomAppbar(
        iconButton: IconButton(
          icon: const Icon(
            Icons.close_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(18, 12, 18, 12),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                'Where should we send a confirmation code',
                style: GoogleFonts.robotoFlex(
                  color: !isDarkMode ? Colors.black87 : Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                '\nBefore you can change your password, we need to make sure it\'s really you.',
                style: GoogleFonts.robotoSlab(
                  color: !isDarkMode ? Colors.black54 : Colors.white24,
                  fontSize: 20,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Text(
                '\nLet\'s text a code to the phone number ending in 47.',
                style: GoogleFonts.roboto(
                    color: !isDarkMode ? Colors.black87 : Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                    key: const ValueKey('cancelForgetScreen2'),
                    color: backgroundColorTheme(context),
                    text: 'Cancel',
                    onPressedCallback: () {
                      Navigator.pop(context);
                    },
                    initialEnabled: true),
                CustomButton(
                    key: const ValueKey('nextForgetScreen2'),
                    color: forgroundColorTheme(context),
                    text: 'Next',
                    onPressedCallback: () {
                      Navigator.push(
                          context,
                          CustomPageRoute(
                              child: const ForgetPasswordPage3(),
                              direction: AxisDirection.left));
                    },
                    initialEnabled: true),
              ],
            )
          ],
        ),
      ),
    );
  }
}
