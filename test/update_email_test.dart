import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/services/update_email.dart';

void main() {
  UpdateEmail service = UpdateEmail(Dio());

  group('update email test', ()  {

    test('Test1: no token provided ', () async {
      expect( await Api.patch(
        url: 'http://16.171.65.142:3000/api/v1/users/email',
        token: "token",
        body: {"token": "code", "email": "email"},
      ), "token not valid");
    });
    log('\n');

    test('Test2: invalid Varification code ', () async {
      expect(await Api.patch(
        url: 'http://16.171.65.142:3000/api/v1/users/email',
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwieXg3a2FjOWU5cThsN2NzcXhzMXNyc3A1aVwiIiwiaWF0IjoxNzAxODAwNDQ4LCJleHAiOjE3MDQzOTI0NDh9.SseNYJIa48vDjVKDfWWE-c6-VRbpvSv5s-PMr6j2XDM",
        body: {"token": "code", "email": "email"},
      ), "email verification code must be 8 characters");
    });
    log('\n');
     test('Test3: email required ', () async {
      expect(await Api.patch(
        url: 'http://16.171.65.142:3000/api/v1/users/email',
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwieXg3a2FjOWU5cThsN2NzcXhzMXNyc3A1aVwiIiwiaWF0IjoxNzAxODAwNDQ4LCJleHAiOjE3MDQzOTI0NDh9.SseNYJIa48vDjVKDfWWE-c6-VRbpvSv5s-PMr6j2XDM",
        body: {"token": "b1a89b10", "email": "email"},
      ), "must have email format");
    });
    log('\n');
     test('Test3: sucess change of email', () async {
      expect(await Api.patch(
        url: 'http://16.171.65.142:3000/api/v1/users/email',
        token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwieXg3a2FjOWU5cThsN2NzcXhzMXNyc3A1aVwiIiwiaWF0IjoxNzAxODAwNDQ4LCJleHAiOjE3MDQzOTI0NDh9.SseNYJIa48vDjVKDfWWE-c6-VRbpvSv5s-PMr6j2XDM",
        body: {"token": "b1a89b10", "email": "ali.aelwa1234@gmail.com"},
      ), "no email request verification found");
    });
    log('\n');
   
    // test('Test3: sucess change of email', () async {
    //   expect(await Api.patch(
    //     url: 'http://16.171.65.142:3000/api/v1/users/email',
    //     token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwieXg3a2FjOWU5cThsN2NzcXhzMXNyc3A1aVwiIiwiaWF0IjoxNzAxODAwNDQ4LCJleHAiOjE3MDQzOTI0NDh9.SseNYJIa48vDjVKDfWWE-c6-VRbpvSv5s-PMr6j2XDM",
    //     body: {"token": "99abef79", "email": "osamamorkos58@gmail.com"},
    //   ), Response<dynamic>:<{"status":"success"}>);
    // });
    // log('\n');
  });
}