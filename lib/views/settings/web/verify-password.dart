import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_paragraph_text.dart';
import 'package:tweaxy/cubits/setting-web-cubit/settings_web_cubit.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';

class VerifyPasswordWeb extends StatefulWidget {
  const VerifyPasswordWeb({super.key});

  @override
  State<VerifyPasswordWeb> createState() => _VerifyPasswordWebState();
}

class _VerifyPasswordWebState extends State<VerifyPasswordWeb> {
  TextEditingController passwordController = TextEditingController();
  bool isButtonEnabled = false;
  @override
  void initState() {
    super.initState();
    passwordController.addListener(() {
      if (passwordController.text.isNotEmpty) {
        setState(() {
          isButtonEnabled = true;
        });
      } else {
        setState(() {
          isButtonEnabled = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        shadowColor: Colors.white,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<SettingsWebCubit>(context).toggleMenu(0);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
        title: const Text(
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
            "Account information",
            textAlign: TextAlign.left),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * .01,
            vertical: MediaQuery.of(context).size.height * 0.01),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomHeadText(
                size: 20,
                textValue: "Confirm your password",
                textAlign: TextAlign.left),
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .04),
              child: CustomParagraphText(
                  size: 15,
                  textValue: "Please enter your password to get this.",
                  textAlign: TextAlign.left),
            ),
          CustomTextField(
                            label: "Password",
                            validatorFunc: (){},
                            controller: passwordController,
                          ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.01,
                  top: MediaQuery.of(context).size.height * 0.01),
              child: InkWell(
                onTap: () {},
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(color: Colors.lightBlue, fontSize: 13),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .02),
              alignment: Alignment.bottomRight,
              child: CustomButton(
                  color: Colors.lightBlue,
                  text: "Confirm",
                  onPressedCallback: () {
                    BlocProvider.of<SettingsWebCubit>(context).toggleMenu(3);
                  },
                  initialEnabled: isButtonEnabled),
            )
          ],
        ),
      ),
    );
  }
}
