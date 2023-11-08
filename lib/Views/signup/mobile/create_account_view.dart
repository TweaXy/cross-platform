import 'package:flutter/material.dart';

import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_create_account_fields.dart';
import 'package:tweaxy/components/custom_date_picker_style.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/transition/custom_page_route.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/mobile/create_account_data_review_view.dart';

import 'package:tweaxy/models/user.dart';

class CreateAccountView extends StatefulWidget {
  const CreateAccountView({super.key});

  @override
  State<CreateAccountView> createState() => _CreateAccountViewState();
}

class _CreateAccountViewState extends State<CreateAccountView> {
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  TextEditingController birthDateFieldController = TextEditingController();
  bool _isnextButtonEnabled = false;
  void showdatepicker(BuildContext contex) {
    setState(() {
      _dateselectview = true;
    });
  }

  @override
  void initState() {
    super.initState();
    nameFieldController.addListener(_updateNextButtonState);
    emailFieldController.addListener(_updateNextButtonState);
    birthDateFieldController.addListener(_updateNextButtonState);
  }

  // SignupService serve = SignupService(Dio());
  // Future<bool> emailUnique() async {
  //   dynamic res = await serve.emailUniqueness(emailFieldController.text);
  //   if (res.statusCode == 200) {
  //     return true;
  //   } else {
  //     Fluttertoast.showToast(
  //         msg: res,
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.CENTER,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.black,
  //         textColor: Colors.white,
  //         fontSize: 16.0);

  //     return false;
  //   }
  // }

  void _updateNextButtonState() async {
    setState(() {
      _isnextButtonEnabled = nameFieldController.text.isNotEmpty &
          birthDateFieldController.text.isNotEmpty &
          emailFieldController.text.isNotEmpty;
    });
  }

  void _setBirthDate(DateTime newDateTime) {
    setState(() {
      birthDateFieldController.text = newDateTime.toString().split(' ')[0];
    });
  }

  bool _dateselectview = false;
  void hideBirthDatePicker(BuildContext context) {
    setState(() {
      _dateselectview = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        iconButton: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: forgroundColorTheme(context),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.53,
              child: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.1,
                    top: MediaQuery.of(context).size.height * 0.02,
                    right: MediaQuery.of(context).size.width * 0.1),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: CustomHeadText(
                        textValue: "Create your account",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    CustomCreateAccountFields(
                        key: const ValueKey("createAccountFields"),
                        birthDateHide: hideBirthDatePicker,
                        birthDateshow: showdatepicker,
                        birthDateFieldController: birthDateFieldController,
                        emailFieldController: emailFieldController,
                        nameFieldController: nameFieldController,
                        topPadding: MediaQuery.of(context).size.height * .03)
                  ],
                ),
              ),
            ),
            if (!_dateselectview)
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
              ),
            SizedBox(
              child: Column(
                children: [
                  Divider(
                    color: forgroundColorTheme(context),
                    thickness: 1.0,
                  ),
                  Align(
                    widthFactor: 4.8,
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                        key: const ValueKey("createAccountNextButton"),
                        color: forgroundColorTheme(context),
                        text: "Next",
                        onPressedCallback: () async {
                          User.email = emailFieldController.text;
                          User.name = nameFieldController.text;
                          User.birthdayDate = birthDateFieldController.text;
                          Navigator.push(
                              context,
                              CustomPageRoute(
                                  direction: AxisDirection.left,
                                  child: CreateAccountDataReview()));
                        },
                        initialEnabled: _isnextButtonEnabled),
                  ),
                ],
              ),
            ),
            if (_dateselectview)
              SizedBox(
                height: MediaQuery.of(context).size.height * .25,
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: CustomDatePicker(setBirthDate: _setBirthDate)),
              )
          ],
        ),
      ),
    );
  }
}
