import 'package:datepicker_dropdown/datepicker_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:tweaxy/components/toasts/custom_web_toast.dart';
import 'package:tweaxy/components/custom_appbar_web.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/components/custom_head_text.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/utilities/date_formating.dart';
import 'package:tweaxy/utilities/theme_validations.dart';
import 'package:tweaxy/views/signup/web/create_account_data_review_web_view.dart';

class CreateAccountWebView extends StatefulWidget {
  const CreateAccountWebView({super.key});

  @override
  State<CreateAccountWebView> createState() => _CreateAccountWebViewState();
}

class _CreateAccountWebViewState extends State<CreateAccountWebView> {
  TextEditingController nameFieldController = TextEditingController();
  TextEditingController emailFieldController = TextEditingController();
  bool _isnextButtonEnabled = false;
  int _selectedDay = 0;
  int _selectedMonth = 0;
  int _selectedYear = 0;
  @override
  void initState() {
    super.initState();
    nameFieldController.addListener(_updateNextButtonState);
    emailFieldController.addListener(_updateNextButtonState);
  }

  void _updateNextButtonState() {
    setState(() {
      _isnextButtonEnabled = nameFieldController.text.isNotEmpty &
          emailFieldController.text.isNotEmpty &
          (_selectedDay != 0) &
          (_selectedMonth != 0) &
          (_selectedYear != 0);
    });
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: backgroundColorTheme(context),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 10,
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.8,
        width: MediaQuery.of(context).size.width * 0.4,
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomAppbarWeb(
                key: const ValueKey("CreateAccountWebAppbar"),
                pageNumber: "1",
                icon: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.close_sharp,
                    color: forgroundColorTheme(context),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                width: MediaQuery.of(context).size.width * 0.38,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.025,
                      top: MediaQuery.of(context).size.height * 0.01,
                      right: MediaQuery.of(context).size.width * 0.025),
                  child: SingleChildScrollView(
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
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                          ),
                          child: CustomTextField(
                              key: const ValueKey(
                                  "CreateAccountWebNameTextField"),
                              label: "Name",
                              validatorFunc: nameValidation,
                              controller: nameFieldController),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.01),
                          child: Form(
                            key: _formKey,
                            child: CustomTextField(
                                key: const ValueKey(
                                    "CreateAccountWebEmailTextField"),
                                label: "Email",
                                validatorFunc: emailValidation,
                                controller: emailFieldController),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height * 0.02,
                              bottom:
                                  MediaQuery.of(context).size.height * 0.01),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: CustomHeadText(
                              textValue: "Date of birth",
                              textAlign: TextAlign.end,
                              size: 20,
                            ),
                          ),
                        ),
                        DropdownDatePicker(
                          yearFlex: 1,
                          textStyle:
                              TextStyle(color: forgroundColorTheme(context)),
                          key: const ValueKey(
                              "CreateAccountWebBirthdayDropdown"),
                          hintDay: 'Day',
                          hintMonth: 'Month',
                          hintYear: 'Year',
                          hintTextStyle:
                              TextStyle(color: forgroundColorTheme(context)),
                          inputDecoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: forgroundColorTheme(context),
                                  width: 1.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: forgroundColorTheme(context),
                                  width: 1.0),
                            ),
                          ),
                          locale: "en",
                          startYear: 1900,
                          endYear: DateTime.now().year,
                          onChangedDay: (value) {
                            _selectedDay = int.parse(value!);
                            _updateNextButtonState();
                          },
                          onChangedMonth: (value) {
                            _selectedMonth = int.parse(value!);
                            _updateNextButtonState();
                          },
                          onChangedYear: (value) {
                            _selectedYear = int.parse(value!);
                            _updateNextButtonState();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: CustomButton(
                  key: const ValueKey("CreateAccountNextButton"),
                  color: forgroundColorTheme(context),
                  text: "Next",
                  onPressedCallback: () {
                    if (_formKey.currentState!.validate()) {
                      User.name = nameFieldController.text;
                      User.email = emailFieldController.text;
                      User.birthdayDate = dateFormating(
                          year: _selectedYear,
                          month: _selectedMonth,
                          day: _selectedDay);
                      showDialog(
                        context: context,
                        builder: (context) =>
                            const CreateAccountDataReviewWebView(),
                        barrierColor: Colors.transparent,
                        barrierDismissible: false,
                      );
                    } else {
                      showToastWidget(
                        const CustomWebToast(
                          message: "Please enter a valid data.",
                        ),
                        position: ToastPosition.bottom,
                        duration: const Duration(seconds: 2),
                      );
                    }
                  },
                  initialEnabled: _isnextButtonEnabled,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
