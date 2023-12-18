import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweaxy/services/temp_user.dart';
import 'package:tweaxy/utilities/custom_text_form_validations.dart';

class CustomUpdateUsernameTextField extends StatefulWidget {
  const CustomUpdateUsernameTextField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  State<CustomUpdateUsernameTextField> createState() =>
      _CustomUpdateUsernameTextFieldState();
}

class _CustomUpdateUsernameTextFieldState
    extends State<CustomUpdateUsernameTextField> {

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
    if (widget.controller.text == TempUser.username) {
      _errorText = "Your new username is the same as your existing username";
      setState(() {
      });
      return;
    }
    try {
      _errorText =
          await updateUsernameValidation(inputValue: widget.controller.text);
      //null or errorText -> validate functions in utilites folder
      setState(() {
        
      });
    } catch (e) {
      log(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      autofocus: true,
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9! @#\$%^&*()_+{}\[\]:;<>,.?~\\/-]')),
      ],
      decoration: InputDecoration(
        labelText: "Username",
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent),
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey.shade200),),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey.shade200),),
            errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        errorText: _errorText,
        errorMaxLines: 5,
      ),
      autovalidateMode: AutovalidateMode.always,
      onChanged: (value) {
       validate();
      },
      onEditingComplete: () {
        validate();
      },
      validator: (value) => _errorText,
    );
  }
}
