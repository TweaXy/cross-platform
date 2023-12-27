import 'package:dio/dio.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

void main() {
  group('Test notification disable', () {
   
     test('Test1: sucess enable  ', () async {
      expect(
          await Api.delete(
            url: '${baseURL}notification/deviceTokenAndorid',
            token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xvdWRlemdnMDAwMDM1Nm1tbW5ybzh6ZVwiIiwiaWF0IjoxNzAzNzA3MzYzLCJleHAiOjE3MDYyOTkzNjN9.iT3hMhHXZKtui8LxUtXwZ6sbEaKDieqrkJ09AnQr_x4",
            body: {"token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xvdWRlemdnMDAwMDM1Nm1tbW5ybzh6ZVwiIiwiaWF0IjoxNzAzNzA3MzYzLCJleHAiOjE3MDYyOTkzNjN9.iT3hMhHXZKtui8LxUtXwZ6sbEaKDieqrkJ09AnQr_x4"},
          ),
         isA<Response<dynamic>>());
    });
    
  });
}
