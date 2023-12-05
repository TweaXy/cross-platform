import 'dart:developer';
import 'dart:ui' as ui;
import 'dart:io' as io;
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/services/FollowersAndFollwing.dart';

void main() {
  followApi service = followApi();
  group('Test Trends Api', () {
    test('Test1: Return List of Followers', () async {
      expect(
          await service.getFollowings(
              username: 'Jalon_Runolfsdottir', pageSize: 5, offset: 0),
          isA<List<FollowersModel>>());
    });
    runTests();
  });
}

void runTests() async {
  await Future.delayed(const Duration(seconds: 30));
}
