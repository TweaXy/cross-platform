import 'package:dio/dio.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

void main() {
  group('Test notification enable', () {
    test('Test1: token not provided', () async {
      expect(
          await Api.post(
            url: '${baseURL}notification/deviceTokenAndorid',
            token: "",
            body: {"": "deviceToken"},
          ),
          "token is required");
    });
     test('Test2: wrong token is given  ', () async {
      expect(
          await Api.post(
            url: '${baseURL}notification/deviceTokenAndorid',
            token: "wrong token",
            body: {"token": "deviceToken"},
          ),
          "token not valid");
    });
     test('Test3: wrong token is given  ', () async {
      expect(
          await Api.post(
            url: '${baseURL}notification/deviceTokenAndorid',
            token: "wrong token",
            body: {"token": "deviceToken"},
          ),
          "token not valid");
    });
     test('Test4: sucess enable  ', () async {
      expect(
          await Api.post(
            url: '${baseURL}notification/deviceTokenAndorid',
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xvdWRlemdnMDAwMDM1Nm1tbW5ybzh6ZVwiIiwiaWF0IjoxNzAzNzA3MzYzLCJleHAiOjE3MDYyOTkzNjN9.iT3hMhHXZKtui8LxUtXwZ6sbEaKDieqrkJ09AnQr_x4",
            body: {"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xvdWRlemdnMDAwMDM1Nm1tbW5ybzh6ZVwiIiwiaWF0IjoxNzAzNzA3MzYzLCJleHAiOjE3MDYyOTkzNjN9.iT3hMhHXZKtui8LxUtXwZ6sbEaKDieqrkJ09AnQr_x4"},
          ),
          isA<Response<dynamic>>());
    });
     test('Test4: token already exists  ', () async {
      expect(
          await Api.post(
            url: '${baseURL}notification/deviceTokenAndorid',
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xvdWRlemdnMDAwMDM1Nm1tbW5ybzh6ZVwiIiwiaWF0IjoxNzAzNzA3MzYzLCJleHAiOjE3MDYyOTkzNjN9.iT3hMhHXZKtui8LxUtXwZ6sbEaKDieqrkJ09AnQr_x4",
            body: {"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xvdWRlemdnMDAwMDM1Nm1tbW5ybzh6ZVwiIiwiaWF0IjoxNzAzNzA3MzYzLCJleHAiOjE3MDYyOTkzNjN9.iT3hMhHXZKtui8LxUtXwZ6sbEaKDieqrkJ09AnQr_x4"},
          ),
          "this token already exists");
    });
  });
}
