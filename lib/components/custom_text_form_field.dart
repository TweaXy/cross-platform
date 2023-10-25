import 'package:flutter/material.dart';

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

  void validate({required String inputValue}) {
    _errorText = widget.validatorFunc(
        inputValue:
            inputValue); //null or errorText -> validate functions in constants folder
    if (_errorText == null) {
      setState(() {
        _isValid = 1;
      });
    } else {
      setState(() {
        _isValid = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: widget.unreadable?? false ,
      controller: widget.controller,
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!(context);
        }
      },
      cursorHeight: 30.0,
      cursorColor: Colors.lightBlue[700],
      obscureText: widget.label == 'Password' ? !passwordVisible : false,
      decoration: InputDecoration(
        filled: true,
        fillColor: _isValid == 2 ? Colors.yellow[200] : Colors.transparent,
        suffixIcon: widget.label != 'Password'
            ? _isValid == 1
                ? const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                  )
                : _isValid == 2
                    ? const Icon(
                        Icons.error,
                        color: Colors.red,
                      )
                    : null
            : IconButton(
                onPressed: () {
                  setState(() {
                    passwordVisible = !(passwordVisible);
                  });
                },
                icon: passwordVisible
                    ? const Icon(Icons.visibility_off)
                    : const Icon(Icons.visibility),
                color: Theme.of(context).primaryColorDark,
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
      onFieldSubmitted: (value) {
        validate(inputValue: value);
      },
    );
  }
}
