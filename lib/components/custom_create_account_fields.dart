import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';
import 'package:tweaxy/shared/keys/sign_up_keys.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';
import 'package:tweaxy/shared/keys/sign_in_keys.dart';

class CustomCreateAccountFields extends StatefulWidget {
  const CustomCreateAccountFields(
      {super.key,
      required this.birthDateHide,
      required this.birthDateshow,
      required this.birthDateFieldController,
      required this.emailFieldController,
      required this.nameFieldController,
      required this.topPadding});
  final Function birthDateHide;
  final Function birthDateshow;
  final double topPadding;
  final TextEditingController nameFieldController;
  final TextEditingController emailFieldController;
  final TextEditingController birthDateFieldController;
  @override
  State<CustomCreateAccountFields> createState() =>
      _CustomCreateAccountFieldsState();
}

class _CustomCreateAccountFieldsState extends State<CustomCreateAccountFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: widget.topPadding),
          child: CustomTextField(
              key: const ValueKey(SignUpKeys.nameFieldKey),
              onTap: widget.birthDateHide,
              label: "Name",
              validatorFunc: nameValidation,
              controller: widget.nameFieldController),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .01),
          child: CustomTextField(
              key: const ValueKey(SignUpKeys.emailFieldKey),
              onTap: widget.birthDateHide,
              label: "Email",
              validatorFunc: emailValidation,
              controller: widget.emailFieldController),
        ),
        Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .03),
          child: CustomTextField(
              key: const ValueKey(SignUpKeys.birthDateFieldKey),
              label: "Date of birth",
              validatorFunc: nameValidation,
              onTap: widget.birthDateshow,
              unreadable: true,
              controller: widget.birthDateFieldController),
        ),
      ],
    );
  }
}
