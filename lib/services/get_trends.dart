import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/trend.dart';

class GetTrendsService {
  GetTrendsService({required this.dio});

  static String token = '';
  final Dio dio;

  Future<List<Trend>> getTrendsList(String? tokenSent,
      {required int pageNumber}) async {
    if (tokenSent != null) {
      token = tokenSent;
    } else {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      token = prefs.getString('token')!;
    }
    log('token:$token');
    String url = '${baseURL}trends?limit=7&offset=$pageNumber';
    Response response = await Api.getwithToken(url: url, token: token);
    List<Map<String, dynamic>> trends =
        (response.data['data']['items'] as List<dynamic>)
            .map((item) => {
                  'name': item['trend'],
                  'count': item['count'],
                })
            .toList();
    log(trends.toString());
    return trends
        .map((e) => Trend(
              name: e['name']!,
              count: e['count']!,
            ))
        .toList();
  }
}
