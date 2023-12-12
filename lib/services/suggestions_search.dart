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
    dynamic response;
    String? token="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xxMmdsYmdsMDAwMGh6M3AyaXV5cjdsM1wiIiwiaWF0IjoxNzAyMzk1NTMwLCJleHAiOjE3MDQ5ODc1MzB9.Jnf7DP-pKpIqPdpCnul5UfbmDrGuAHEELdln-5oYJvI";
    // try {
    //   List<String> s = await loadPrefs();
    //   token = s[1];
    // } catch (e) {
    //   log(e.toString());
    // }
    try {
      response = await Api.getwithToken(
        url:
            '${baseUrl}tweets/suggest?keyword=$query&limit=value&offset=$pagenumber',
        token: token,
      );
      log(response.toString());
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

List<String> formatSuggestions(dynamic response) {
  List<String> items = [];
  for (var i in response.data['data']['item']) {
    items.add(i["rightSnippet"]);
    items.add(i["leftSnippet"]);
  }

  return items;
}
