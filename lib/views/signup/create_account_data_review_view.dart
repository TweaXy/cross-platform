import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/review_input_text_field.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/authentication_view.dart';

class CreateAccountDataReview extends StatefulWidget {
  const CreateAccountDataReview(
      {super.key,
      required this.birthdate,
      required this.email,
      required this.name});
  final String name;
  final String email;
  final String birthdate;
  @override
  State<CreateAccountDataReview> createState() =>
      _CreateAccountDataReviewState();
}

class _CreateAccountDataReviewState extends State<CreateAccountDataReview> {
  void _naviagationaction(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: CustomAppbar(
                key: const ValueKey("createAccountDataReviewAppbar"),
                iconButton: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: forgroundColorTheme(context),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                    // _naviagationaction;
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 16, 30, 0),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: CustomHeadText(
                        textValue: "Create your account",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ReviewInputTextField(
                          textValue: widget.name, label: "Name"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ReviewInputTextField(
                          label: "email", textValue: widget.email),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: ReviewInputTextField(
                          label: "Date of Birth", textValue: widget.birthdate),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            SizedBox(
              child: Align(
                  widthFactor: 4.8,
                  alignment: Alignment.center,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      key: const ValueKey("createAccountDataReviewNextButton"),
                      onPressed: () {
                        Navigator.push(
                            context,
                            CustomPageRoute(
                                direction: AxisDirection.left,
                                child: const AuthenticationView()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            forgroundColorTheme(context), // Background color
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Colors.blueGrey.shade200)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 4),
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                              color: backgroundColorTheme(context),
                              fontWeight: FontWeight.w600,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
