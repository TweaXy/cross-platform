import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/services/update_email.dart';

void main() {
  UpdateEmail service = UpdateEmail(Dio());

  group('update_email', () async {

    test('Test1: email not exist ', () async {
      expect(await service.changeEmail("kccz", ""), "email is required field");
    });
    log('\n');

    test('Test2: sucess change of mail', () async {
      expect(await service.changeEmail( "3341eecd@","nesmashafie342@gmail.com"), null);
    });
    log('\n');
 SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token","556d");
    // test('Test3: wrong code ', () async {
    //   expect(await service.changeEmail( "3341eecd@","nesmashafie342@gmail.com"), "ser not authorized.");

    // });

  });
}