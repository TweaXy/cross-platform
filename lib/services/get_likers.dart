import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/followers_model.dart';

class Likers {
  final dio = Dio();
  Likers();

  Future<List<FollowersModel>> getLikers(
      {required ScrollController scroll,
      required String id,
      required int offset}) async {
    dynamic response;
    String token;
    SharedPreferences user = await SharedPreferences.getInstance();
    token = user.getString("token")!;
    response = await Api.getwithToken(
      url:
          "http://16.171.65.142:3000/api/v1/interactions/$id/likers?limit=10&offset=$offset",
      token: token,
    );
    Map<String, dynamic> jsondata = response.data;
    print(response.data);
    List<dynamic> allData = jsondata['data']["users"];
    List<FollowersModel> allFollowers = [];
    for (int i = 0; i < allData.length; i++) {
      FollowersModel follower = FollowersModel.fromJson(allData[i]);
      allFollowers.add(follower);
    }
    return allFollowers;
  }
}