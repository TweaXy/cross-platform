import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_text_form_field.dart';

void main() {
  runApp(const MainMaterialApp());
}

class MainMaterialApp extends StatelessWidget {
  const MainMaterialApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Center(
            child: CustomTextField(label: 'Email'),
          ),
        ));
  }
}
