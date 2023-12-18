import 'package:flutter/material.dart';
import 'package:tweaxy/services/temp_user.dart';

class UpdateUsernameDisabledTextfield extends StatelessWidget {
  const UpdateUsernameDisabledTextfield({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: TempUser.username,
      style: TextStyle(
        height: 1.5,
        color: Colors.blueGrey.shade200,
      ),
      readOnly: true,
      decoration: InputDecoration(
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabled: false,
        labelText: "Current",
        labelStyle: TextStyle(
          color: Colors.blueGrey.shade200,
          fontSize: 20,
          fontWeight: FontWeight.w400,
        ),
        border: const UnderlineInputBorder(
          borderSide: BorderSide(),
        ),
        disabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
      ),
    );
  }
}
