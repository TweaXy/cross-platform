import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/services/add_tweet.dart';

void main() {
  AddTweet service = AddTweet(Dio());
  group('Test add tweet Api', () {
    test('Test1: post empty tweet', () async {
      
      expect(await service.addTweet("",[]), "no token provided");
    });

  log('\n');
    
  });
}
