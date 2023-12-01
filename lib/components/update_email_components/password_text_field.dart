import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tweaxy/utilities/theme_validations.dart';

class PasswordTextField extends StatefulWidget {
 const  PasswordTextField({super.key, required this.passwordcontroller,required this.isButtonEnabled});
  final TextEditingController passwordcontroller;
  final bool isButtonEnabled;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool passwordVisible = false;

  List<Widget> showIcons() {
    List<Widget> suffixIcons = [];

    suffixIcons.add(
      IconButton(
        onPressed: () {
          setState(() {
            passwordVisible = !(passwordVisible);
          });
        },
        icon: passwordVisible
            ? const Icon(Icons.visibility)
            : const Icon(Icons.visibility_off),
        color: iconColorTheme(context),
      ),
    );

    if (widget.isButtonEnabled) {
      suffixIcons.add(const Icon(
        Icons.check_circle,
        color: Colors.green,
      ));
    }
    return suffixIcons;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
       inputFormatters: [
        FilteringTextInputFormatter.allow(
            RegExp(r'[a-zA-Z0-9! @#\$%^&*()_+{}\[\]:;<>,.?~\\/-]')),
      ],
        maxLength: 100,
        cursorHeight: 30.0,
        cursorColor: Colors.lightBlue[700],
        decoration: InputDecoration(
          counterText: "",
          suffixIcon: Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Row(mainAxisSize: MainAxisSize.min, children: showIcons()),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
          labelText: "Password",
          border: const OutlineInputBorder(borderSide: BorderSide()),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue[700]!, width: 2.0),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
        ),
        obscureText: !passwordVisible,
        controller: widget.passwordcontroller);
  }
}
