import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/followers_model.dart';

class followApi {
  final dio = Dio();
  followApi();
  Future<List<FollowersModel>> getFollowers({
    required String username,
    required int offset,
    required int pageSize,
  }) async {
    dynamic response;
    String token;

    SharedPreferences user = await SharedPreferences.getInstance();
    token = user.getString("token")!;
    print(token);
    response = await Api.getwithToken(
      url:
          "https://tweaxybackend.mywire.org/api/v1/users/followers/$username?limit=$pageSize&offset=$offset",
      token: token,
    );
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

  Future<List<FollowersModel>> getFollowings(
      {required String username,
      required int offset,
      required int pageSize}) async {
    dynamic response;
    String token;
    SharedPreferences user = await SharedPreferences.getInstance();
    token = user.getString("token")!;
    print(token);
    response = await Api.getwithToken(
      url:
          "https://tweaxybackend.mywire.org/api/v1/users/followings/$username?limit=$pageSize&offset=$offset",
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
