import 'dart:developer';

import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/helpers/api.dart';




void main() {
  Future<dynamic> enableNatification(String token) async {
  dynamic response;

    response = await Api.post(
      url: 'https://tweaxybackend.mywire.org/api/v1/notification/status',
      token: token,
      body: {"token": token, "type": "android"},
    );

    return response;
  
}
  group('Test Notification Settings enable Api', () {
    test('Test1:enable notification successfully', () async {
      dynamic result = await enableNatification("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xxbnF4ZnZxMDBibzdzejZqNGwzaHFveFwiIiwiaWF0IjoxNzAzNjkwNzc0LCJleHAiOjE3MDYyODI3NzR9.j4vR2DVH5rZ02KnQ9rLfB_rH5f4LXf1lau1pU3xy6gU");
      expect(result, "success");
    });
    log("\n");
    test('Test 2: token is invalid', () async {
      dynamic result = await enableNatification("");
      expect(result, "user not authorized.");
    });
    test('Test 2: token is required', () async {
      dynamic result = await enableNatification("");
      expect(result, "token is required");
    });
  });
}