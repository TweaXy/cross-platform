import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:tweaxy/services/add_tweet_and_reply.dart';

void main() {
  AddTweetAndReply service = AddTweetAndReply(Dio());
  group('Test add tweet Api', () {
    test('Test1: post empty tweet', () async {
      expect(await service.addTweet("", []), "tweet can not be empty");
    });
    log('\n');

    test('Test2: post tweet with text only ', () async {
      final response = await service.addTweet('test tweet', []);

      expect(response.statusCode == 201, true);
    });
    log('\n');

    log('\n');
    test('Test3: post tweet with text and media', () async {
      XFile img = XFile('assets\\girl.jpg');
      final response = await service.addTweet('testTwet', [img, img]);
      expect(response.statusCode == 201, true);
    });
    log('\n');

    // test('Test4: post tweet with text and video', () async {
    //   XFile video = XFile('assets\\video (2160p).mp4');
    //   final response = await service.addTweet('testTwet', [video]);
    //   expect(response.statusCode == 201, true);
    // });
    log('\n');
  });
}
