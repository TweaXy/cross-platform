import 'dart:math';

import 'package:dio/dio.dart';
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
    SharedPreferences user = await SharedPreferences.getInstance();
    String username = user.getString("username")!;
    String token = user.getString("token")!;
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
    SharedPreferences user = await SharedPreferences.getInstance();
    String username = user.getString("username")!;
    String token = user.getString("token")!;
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
