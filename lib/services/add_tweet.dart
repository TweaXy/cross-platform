import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/helpers/api.dart';

class AddTweet {
  final Dio dio;
  final String baseUrl = 'http://16.171.65.142:3000/api/v1/';

  AddTweet(this.dio);

  Future addTweet(String text, List<XFile> media) async {
    dynamic response;
    print(text);
    print(media);
    String? token;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = null;
    // Save user information
    var retrivedtoken = prefs.getString("token");
    token = retrivedtoken;
    print(token);
    try {
      response = await Api.post(
        url: '${baseUrl}tweets/',
        token:
            "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xwamd0cGt5MDAwMjJ2aGh3Y21pY2xucVwiIiwiaWF0IjoxNzAxMjU4ODQzLCJleHAiOjE3MDM4NTA4NDN9.9gZpl_dfOQwYPJEMLnbrjMh9Lt6ECSKuUSTUMlWeRPY",
        body: {text: "222", media: []},
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('oops something went wrong');
    }
  }
}
