import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tweaxy/components/custom_dialog_app_bar.dart';
import 'package:tweaxy/components/custom_appbar_web.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class ResetPasswordWeb2 extends StatefulWidget {
  const ResetPasswordWeb2({super.key});

  @override
  State<ResetPasswordWeb2> createState() => _ResetPasswordWeb2State();
}

class _ResetPasswordWeb2State extends State<ResetPasswordWeb2> {
  @override
  Widget build(BuildContext context) {
    double screenwidth = MediaQuery.of(context).size.width;
    double screenheight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Column(
        children: [
          AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            centerTitle: true,
            title: SvgPicture.asset(
              width: 50,
              height: 50,
              'assets/images/logo.svg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: screenheight * 0.04, right: screenwidth * 0.08),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomHeadText(
                  size: 35,
                  textValue: 'You\'re all set',
                  textAlign: TextAlign.left,
                ),
                Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height * 0.02),
                    child: CustomParagraphText(
                        textValue: 'You\'ve successfully changed your password',
                        textAlign: TextAlign.left)),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: screenheight * 0.21),
            child: SizedBox(
                width: 500,
                height: 50,
                child: CustomButton(
                    key: const ValueKey("ContinueToXButtonWeb"),
                    color: forgroundColorTheme(context),
                    text: 'Continue to X',
                    onPressedCallback: () async {
                      Navigator.pop(context);
                    },
                    initialEnabled: true)),
          ),
        ],
      ),
    );
  }
}
