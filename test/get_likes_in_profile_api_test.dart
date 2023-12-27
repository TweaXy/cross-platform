import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';



void main() async {
Future<Object> getLikes(String id, int page, String? token) async {
  return await await Api.getwithToken(
      url: '${baseURL}users/tweets/liked/$id?limit=4&offset=$page',
      token: token);
  
}
  group('GetUserById testing', () {
    test('Test1 : Get liked Tweet Successfuly', () async {
      expect(await getLikes("", 0,null), "no token provided");
    });
    test('Test2 : Wrong ID ', () async {
      expect(
          await getLikes("2155", 0,
              "token"),
        "token not valid");
    });

    test('Test3 : not send user id ', () async {
      expect(await getLikes("", 0,"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiYTQ0bzlsem9qbGtybnZscmxhZDQ4dW1jN1wiIiwiaWF0IjoxNzAzNzExMTY0LCJleHAiOjE3MDYzMDMxNjR9.GoHIWsZ8mOeCWxyP_nszBXDxfY-BhVcLHzCyZjwKqeQ"),
       "no user found ");
    });
    
     test('Test4 : sucess get  ', () async {
      expect(await getLikes("a44o9lzojlkrnvlrlad48umc7", 0,"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiYTQ0bzlsem9qbGtybnZscmxhZDQ4dW1jN1wiIiwiaWF0IjoxNzAzNzExNTIwLCJleHAiOjE3MDYzMDM1MjB9.IwwR_Da6_YgIcxE04QR6pQph55G6yGP8uWwD7zK7oYM"),
       isA<Response<dynamic>>());
    });
  });
}
