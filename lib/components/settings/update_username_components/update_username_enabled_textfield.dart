import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';

class UpdateUsernameEnabledTextfield extends StatefulWidget {
  const UpdateUsernameEnabledTextfield({super.key, required this.controller});
  final TextEditingController controller;

  @override
  State<UpdateUsernameEnabledTextfield> createState() =>
      _UpdateUsernameEnabledTextfieldState();
}

class _UpdateUsernameEnabledTextfieldState
    extends State<UpdateUsernameEnabledTextfield> {
  int _isValid = 0;
  String? _errorText;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void validate() async {
    if (widget.controller.text.trim() == TempUser.username) {
      _errorText = "Your new username is the same as your existing username";
      setState(() {
        _isValid = 2;
      });
      return;
    }
    try {
      _errorText =
          await updateUsernameValidation(inputValue: widget.controller.text);
      //null or errorText -> validate functions in utilites folder
      if (_errorText == null) {
        setState(() {
          _isValid = 1;
        });
      } else {
        setState(() {
          _isValid = 2;
        });
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9! @#\$%^&*()_+{}\[\]:;<>,.?~\\/-]')),
      ],
      controller: widget.controller,
      style: const TextStyle(
        height: 1.5,
      ),
      decoration: InputDecoration(
        prefix: Padding(
          padding: const EdgeInsets.only(right: 3.0),
          child: Text(
            '@',
            style: TextStyle(
              color: Colors.blueGrey.shade200,
            ),
          ),
        ),
        suffix: _isValid == 0
            ? null
            : _isValid == 1
                ? const Icon(
                    Icons.check_circle_outline,
                    color: Colors.green,
                  )
                : const Icon(
                    Icons.error_outline_rounded,
                    color: Colors.red,
                  ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: "New",
        labelStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorText: _errorText,
        errorMaxLines: 5,
      ),
      autovalidateMode: AutovalidateMode.always,
      onChanged: (value) {
        validate();
      },
      validator: (value) => _errorText,
    );
  }
}
