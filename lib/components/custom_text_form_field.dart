import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    Key? key,
    required this.label,
    required this.controller,
  }) : super(key: key);

  final String label;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _isValid = 0;

  void validate() {
    if ((_formKey.currentState)!.validate()) {
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
    return Form(
      key: _formKey,
      child: TextFormField(
        controller: widget.controller,
        cursorHeight: 30.0,
        cursorColor: Colors.lightBlue[700],
        decoration: InputDecoration(
          filled: true,
          fillColor: _isValid == 2 ? Colors.yellow[200] : Colors.transparent,
          suffixIcon: _isValid == 1
              ? const Icon(
                  Icons.check_circle,
                  color: Colors.green,
                )
              : _isValid == 2
                  ? const Icon(
                      Icons.error,
                      color: Colors.red,
                    )
                  : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
          labelText: widget.label,
          border: OutlineInputBorder(
            borderSide: _isValid == 1
                ? const BorderSide()
                : const BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue[700]!, width: 2.0),
          ),
          errorText: _isValid == 2 ? '' : null,
          errorStyle: const TextStyle(backgroundColor: Colors.transparent),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your ${widget.label}';
          }
          return null;
        },
        onFieldSubmitted: (value) {
          validate();
        },
      ),
    );
  }
}
