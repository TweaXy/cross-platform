import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/followers_model.dart';
import 'package:tweaxy/models/user.dart';

class SearchForUsers {
  static const String _endpoint = 'users/search/';
  SearchForUsers._();
  static Future<List<User>> searchForUser(String query, String token,
      {int pageSize = 100, int pageNumber = 0}) async {
    var response = await Api.getwithToken(
        url: '$baseURL$_endpoint$query?limit=$pageSize&offset=$pageNumber',
        token: token);
    var data = response.data['data']['users'] as List<dynamic>;
    List<User> u = [];
    for (var i = 0; i < data.length; i++) {
      u.add(
        User(
          id: data[i]['id'],
          name: data[i]['name'],
          userName: data[i]['username'],
          avatar: data[i]['avatar'],
          followers: data[i]['followsMe'] ? 1 : 0,
          following: data[i]['followedByMe'] ? 1 : 0,
        ),
      );
    }
    return u;
  }

  static Future<List<FollowersModel>> searchForUserinside({
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
      url: '$baseURL$_endpoint$username?limit=$pageSize&offset=$offset',
      token: token,
    );
    Map<String, dynamic> jsondata = response.data;
    print(response.data);
    List<dynamic> allData = jsondata['data']['users'] as List<dynamic>;
    List<FollowersModel> allFollowers = [];
    for (int i = 0; i < allData.length; i++) {
      FollowersModel follower = FollowersModel.fromJson(allData[i]);
      allFollowers.add(follower);
    }
    return allFollowers;
  }
}
