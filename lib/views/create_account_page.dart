import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_appbar.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_create_account_fields.dart';
import 'package:tweaxy/components/custom_date_picker_style.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class CrearAccount extends StatefulWidget {
  const CrearAccount({super.key});

  @override
  State<CrearAccount> createState() => _CrearAccountState();
}

class _CrearAccountState extends State<CrearAccount> {
  void _naviagationaction(BuildContext context) {}
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

  void _updateNextButtonState() {
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
            height: MediaQuery.of(context).size.height * 0.53,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 16, 30, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: CustomHeadText(
                      textValue: "Create your account",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomCreateAccountFields(
                      birthDateHide: hideBirthDatePicker,
                      birthDateshow: showdatepicker,
                      birthDateFieldController: birthDateFieldController,
                      emailFieldController: emailFieldController,
                      nameFieldController: nameFieldController,
                      topPadding: 25)
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
                      color: forgroundColorTheme(context),
                      text: "Next",
                      onPressedCallback: () {},
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
    );
  }
}
