import 'package:flutter/material.dart';
import 'package:tweaxy/components/custom_button.dart';
import 'package:tweaxy/views/create_account_page.dart';
import 'package:tweaxy/views/login_view_page1.dart';

void main() {
  runApp(const tweaxy());
}

class tweaxy extends StatelessWidget {
  const tweaxy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData.light(),
        debugShowCheckedModeBanner: false,
        home: const Scaffold(body: CrearAccount()));
  }
}
