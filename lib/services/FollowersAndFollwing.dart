import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/models/users.dart';
import 'package:url_launcher/url_launcher.dart';

class followApi {
  final dio = Dio();
  followApi();
  Future<List<FollowersModel>> getFollowers() async {
    dynamic response;
    String token;
    String username;
    if (kIsWeb) {
      username = 'karim.elsayed401_13086663';
      token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xwamlseWJvMDAwMzJ2aGhnajd3M3B2OFwiIiwiaWF0IjoxNzAxMjU2Nzk2LCJleHAiOjE3MDM4NDg3OTZ9.6cM_kH7Zacxr1eDykPBrVPS7XP63c-S3n2EFDzDtVak';
    } else {
      SharedPreferences user = await SharedPreferences.getInstance();
      username = user.getString("username")!;
      print(username);
      token = user.getString("token")!;
    }
    response = await Api.getwithToken(
        url:
            "http://16.171.65.142:3000/api/v1/users/followers/$username?limit=50&offset=0",
        token: token);
    Map<String, dynamic> jsondata = response.data;
    print(response.data);
    List<dynamic> allData = jsondata['data']["followers"];
    List<FollowersModel> allFollowers = [];
    for (int i = 0; i < allData.length; i++) {
      FollowersModel follower = FollowersModel.fromJson(allData[i]);
      allFollowers.add(follower);
    }
    return allFollowers;
  }

  Future<List<FollowersModel>> getFollowings() async {
    dynamic response;
    String token;
    String username;
    if (kIsWeb) {
      username = 'karim.elsayed401_13086663';
      token =
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IlwiY2xwamlseWJvMDAwMzJ2aGhnajd3M3B2OFwiIiwiaWF0IjoxNzAxMjU2Nzk2LCJleHAiOjE3MDM4NDg3OTZ9.6cM_kH7Zacxr1eDykPBrVPS7XP63c-S3n2EFDzDtVak';
    } else {
      SharedPreferences user = await SharedPreferences.getInstance();
      username = user.getString("username")!;
      print(username);
      token = user.getString("token")!;
    }
    response = await Api.getwithToken(
      url:
          "http://16.171.65.142:3000/api/v1/users/followings/$username?limit=50&offset=0",
      token: token,
    );
    Map<String, dynamic> jsondata = response.data;
    print(response.data);
    List<dynamic> allData = jsondata['data']["followings"];
    List<FollowersModel> allFollowings = [];
    for (int i = 0; i < allData.length; i++) {
      FollowersModel following = FollowersModel.fromJsoning(allData[i]);
      allFollowings.add(following);
    }
    return allFollowings;
  }
}
