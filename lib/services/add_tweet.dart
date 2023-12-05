import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/helpers/api.dart';
import 'dart:typed_data';

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
    token = prefs.getString("token");

    List<Uint8List> newMedia = [];

    for (XFile m in media) {
      final bytes = await File(m.path).readAsBytes();
      newMedia.add(bytes);
    }
    FormData formData = FormData.fromMap({'text': text, 'media': newMedia});

    print(token);
    try {
      response = await Api.post(
        url: '${baseUrl}tweets/',
        token: token,
        body: formData,
      );
      return response;
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('oops something went wrong');
    }
  }

 Future addTweetWeb(String text, List<Uint8List> media) async {
  dynamic response;
  print(text);
  print(media);
  String? token;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  token = prefs.getString("token");

  // Create FormData
  FormData formData = FormData();

  // Add text field
  formData.fields.add(MapEntry('text', text));

  // Add media files
  for (int i = 0; i < media.length; i++) {
    // Add each media as a separate field
    formData.fields.add(MapEntry(
      'media_$i',
      MultipartFile.fromBytes(media[i], filename: 'media_$i') as String,
    ));
  }

  print(token);
  try {
    response = await Api.post(
      url: '${baseUrl}tweets/',
      token: token,
      body: formData,
    );
    return response;
  } catch (e) {
    if (kDebugMode) {
      log(e.toString());
    } // debug mode only
    throw Exception('Oops, something went wrong');
  }
}


}
