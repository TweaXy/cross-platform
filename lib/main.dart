import 'package:flutter/material.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/views/login/login_view_page1.dart';
import 'package:tweaxy/views/signup/create_account_view.dart';

void main() {
  runApp(const TweaXy());
}

class TweaXy extends StatelessWidget {
  const TweaXy({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        kLogin1Screen: (context) => const LoginViewPage1(),
        kCreateAcountScreen: (context) => const CreateAccountView(),
      },
      initialRoute: kCreateAcountScreen,
    );
  }
}
