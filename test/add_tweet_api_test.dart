import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/services/add_tweet.dart';

void main() {
  AddTweet service = AddTweet(Dio());
  group('Test add tweet Api', () async {
    test('Test1: post empty tweet', () async {
      expect(await service.addTweet("",[]), "tweet can not be empty.");
    });
  log('\n');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token","556d");
     test('Test2: post with not valid token ', () async {
      expect(await service.addTweet("hi tweet",[]), "no user found.");
    });

  });
}
