import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tweaxy/constants.dart';
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
      try {
      List<String> s = await loadPrefs();
      token = s[1];
    } catch (e) {
      log(e.toString());
    }
    Map<String, dynamic> data = {};
    if (text.isNotEmpty) {
      data['text'] = text;
    }
    List<MultipartFile> newMedia = [];

    for (XFile m in media) {
      final bytes = await (m).readAsBytes();
      final med = MultipartFile.fromBytes(bytes.toList(),
          contentType: m.path.contains('mp4')
              ? MediaType('video', 'mp4')
              : MediaType('image', 'png'),
          filename: m.path.split('/').last);
      newMedia.add(med);
    }
    if (newMedia.isNotEmpty) {
      data['media'] = newMedia;
    }
    FormData formData = FormData.fromMap(data);

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
}
