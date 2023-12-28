import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/helpers/api.dart';

void main() {
  Future<dynamic> enableNotification(String token) async {
    dynamic response;

    response = await Api.post(
      url: 'https://tweaxybackend.mywire.org/api/v1/notification/status',
      token: token,
      body: {"token": token, "type": "android"},
    );

    return response;
  }

  group('Test Notification Settings enable Api', () {
    test('Test 1: enable notification successfully', () async {
      dynamic result = await enableNotification("eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xvdWRlemdnMDAwMDM1Nm1tbW5ybzh6ZVwiIiwiaWF0IjoxNzAzNzA3MzYzLCJleHAiOjE3MDYyOTkzNjN9.iT3hMhHXZKtui8LxUtXwZ6sbEaKDieqrkJ09AnQr_x4");
      expect(result,  isA<Response<dynamic>>());
    });

    test('Test 2: token is invalid', () async {
      dynamic result = await enableNotification( "eyJhbGciOiJIUzI1Ni");
      expect(result, "token not valid");
    });

    test('Test 3: token is required', () async {
      dynamic result = await enableNotification(""); // Pass null or any invalid token
      expect(result, "token is required");
    });
  });
}
