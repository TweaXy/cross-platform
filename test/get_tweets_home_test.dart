// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:test/expect.dart';
// import 'package:test/scaffolding.dart';
// import 'package:tweaxy/services/tweets_services.dart';

// void main() {
//   group('Test Get Tweets in Home Api', () {
//     print('\n');
//     setToken();
//     test('Test1: Check Get Tweets in Home for invalid token', () async {
//       expect(await TweetsServices.getTweetsHome(offset: 5),
//           "must have email format");
//     });
//     print('\n');
//     // test('Test2: Check Reset Token for invalid email and token', () async {
//     //   SignInServices.setEmail(email: 'k');
//     //   SignInServices.setToken(token: 'k');

//     //   expect(await SignInServices.checkResetToken(),
//     //       "email verification code must be 8 characters");
//     // });
//     // test('Test3: Check Reset Token for invalid email and token', () async {
//     //   SignInServices.setEmail(email: 'k@gmail.com');
//     //   SignInServices.setToken(token: 'k0000000');

//     //   expect(await SignInServices.checkResetToken(), "User not found");
//     // });
//   });
// }

// void setToken() async {
//   runApp(Container());
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   prefs.setString('token', 'hhh');
// }
