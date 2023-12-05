import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/models/trend.dart';
import 'package:tweaxy/services/get_trends.dart';

void main() {
  GetTrendsService service = GetTrendsService(dio: Dio());
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiZGw0MDNxNWhrbmM5c3FldjM2ZGN2N3RuYlwiIiwiaWF0IjoxNzAxNjk2NDQ1LCJleHAiOjE3MDQyODg0NDV9.VEUGnHlqy_4P6zvMSEH2Z_BhSHn-qP8YM1ioW8ilcDI';
  group('Test Trends Api', () {
    test('Test1: Return List of trends', () async {
      expect(await service.getTrendsList(token, limit: 5, pageNumber: 0),
          isA<List<Trend>>());
    });
    log('\n');
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
