import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_app_bar.dart';

class ForgetPasswordPage2 extends StatelessWidget {
  const ForgetPasswordPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(context),
      body: Column(children: [
        Text(
          'Where should we send a confirmation code',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
      ]),
    );
  }
}
