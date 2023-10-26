import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/review_input_text_field.dart';
import 'package:tweaxy/constants/theme_validations.dart';

class CreateAccountDateReview extends StatefulWidget {
  const CreateAccountDateReview(
      {super.key,
      required this.birthdate,
      required this.email,
      required this.name});
  final String name;
  final String email;
  final String birthdate;
  @override
  State<CreateAccountDateReview> createState() =>
      _CreateAccountDateReviewState();
}

class _CreateAccountDateReviewState extends State<CreateAccountDateReview> {
  void _naviagationaction(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: CustomAppbar(
              iconAction: _naviagationaction,
              iconShape: Icon(
                Icons.arrow_back,
                color: forgroundColorTheme(context),
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
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child:
                        ReviewInputTextField(label: "Name", value: widget.name),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ReviewInputTextField(
                        label: "Email", value: widget.email),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ReviewInputTextField(
                        label: "Date of Birth", value: widget.birthdate),
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
                  height: MediaQuery.of(context).size.height*0.07,
                  width: MediaQuery.of(context).size.width*0.8,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          forgroundColorTheme(context), // Background color
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: BorderSide(color: Colors.blueGrey.shade200)),
                    ),
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
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
    );
  }
}
