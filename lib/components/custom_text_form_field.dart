import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField(
      {super.key,
      required this.label,
      required this.validatorFunc,
      required this.controller,
      this.onTap,
      this.unreadable});
  final String label;
  final Function validatorFunc;
  Function? onTap = () {};
  final TextEditingController controller;
  bool? unreadable = false;
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  int _isValid = 0; //0 for initial state, 1 for valid, 2 for invalid
  String? _errorText; //should be null if the input is valid or in initial state
  bool passwordVisible = false;

  bool isPassword({required String label}) {
    if (label == "Password" ||
        label == "Enter a new password" ||
        label == "Confirm your password") {
      return true;
    } else {
      return false;
    }
  }

  void validate({required String inputValue}) async {
    try {
      _errorText = await widget.validatorFunc(
          inputValue:
              inputValue); //null or errorText -> validate functions in utilites folder
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

  Widget passwordIcons() {
    return (IconButton(
      onPressed: () {
        setState(() {
          passwordVisible = !(passwordVisible);
        });
      },
      icon: passwordVisible
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: iconColorTheme(context),
    ));
  }

  List<Widget> showIcons() {
    List<Widget> suffixIcons = [];
    if (isPassword(label: widget.label)) {
      suffixIcons.add(passwordIcons());
    }
    if (_isValid != 0) {
      suffixIcons.add(_isValid == 1
          ? const Icon(
              Icons.check_circle,
              color: Colors.green,
            )
          : const Icon(
              Icons.error,
              color: Colors.red,
            ));
    }
    return suffixIcons;
  }

  @override
  Widget build(BuildContext context) {
    showIcons();
    return TextFormField(
      inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9! @#\$%^&*()_+{}\[\]:;<>,.?~\\/-]')),
      ],
      readOnly: widget.unreadable ?? false,
      controller: widget.controller,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(context);
        }
      },
      cursorHeight: 30.0,
      cursorColor: Colors.lightBlue[700],
      obscureText: isPassword(label: widget.label) ? !passwordVisible : false,
      maxLength: widget.label == 'Name' ? 50 : null,
      decoration: InputDecoration(
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: showIcons()),
        ),
        contentPadding:
            const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
        labelText: widget.label,
        border: const OutlineInputBorder(borderSide: BorderSide()),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue[700]!, width: 2.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        errorText: _errorText,
      ),
      onChanged: (value) async {
        validate(inputValue: value);
      },
      autovalidateMode: AutovalidateMode.always,
      validator: (value) => _errorText,
    );
  }
}
