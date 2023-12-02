import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class FollowUser {
  final String _endpoint = 'users/follow/';
  FollowUser._();
  static final instance = FollowUser._();
  Future<void> followUser(String username) async {
    String token;
    SharedPreferences user = await SharedPreferences.getInstance();
    token = user.getString("token")!;
    // }
    var response = await Api.post(
        url: baseURL + _endpoint + username, body: {}, token: token);
    print(response.toString());
    // return response.statusCode == 200;
  }

  Future<void> deleteUser(String username) async {
    String token;

    SharedPreferences user = await SharedPreferences.getInstance();
    token = user.getString("token")!;
    // }
    var response = await Api.delete(
        url: baseURL + _endpoint + username, body: {}, token: token);
    print(response.toString());
    // return response.statusCode == 200;
  }
}
