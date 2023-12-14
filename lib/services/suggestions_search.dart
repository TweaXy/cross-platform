import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class SuggestionsSearch {
  final Dio dio;
  final String baseUrl = 'https://tweaxybackend.mywire.org/api/v1/';

  SuggestionsSearch(this.dio);

  Future getSuggesstion(String query, int pagenumber) async {
    Response response;
    String? token;
    try {
      List<String> s = await loadPrefs();
      token = s[1];
    } catch (e) {
      log(e.toString());
    }
    try {
      response = await Api.getwithToken(
        url:
           '${baseUrl}tweets/suggest?keyword=$query&limit=7&offset=$pagenumber',
        token: token,
      );
      // log(response.toString());
      return formatSuggestions(response);
    } catch (e) {
      if (kDebugMode) {
        log(e.toString());
      } //debug mode only
      throw Exception('suggestions error ');
    }
  }

  print(response) {}
}

List<String> formatSuggestions(Response response) {
  List<String> items = [];
  var data=response.data;
  // var itemsa=data[1];
  for (var i in response.data['data']['items']) {
    items.add(i["rightSnippet"]);
    items.add(i["leftSnippet"]);
  }

  return items;
}