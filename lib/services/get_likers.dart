import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/followers_model.dart';

class Likers {
  final dio = Dio();
  Likers();

  Future<List<FollowersModel>> getLikers({
    required String id,
    required int offset,
    required int pageSize,
  }) async {
    dynamic response;
    String token;
    SharedPreferences user = await SharedPreferences.getInstance();
    token = user.getString("token")!;
    response = await Api.getwithToken(
      url:
          "${baseURL}interactions/$id/likers?limit=$pageSize&offset=$offset",
      token: token,
    );
    Map<String, dynamic> jsondata = response.data;
    print(response.data);
    List<dynamic> allData = jsondata['data']["likers"];
    List<FollowersModel> allFollowers = [];
    for (int i = 0; i < allData.length; i++) {
      FollowersModel follower = FollowersModel.fromJsonLikers(allData[i]);
      allFollowers.add(follower);
    }
    return allFollowers;
  }
}
