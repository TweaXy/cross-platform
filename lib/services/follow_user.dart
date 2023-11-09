import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class FollowUser {
  final String _endpoint = 'users/follow/';
  FollowUser._();
  static final instance = FollowUser._();
  Future<bool> followUser(String id, String token) async {
    var response =
        await Api.post(url: baseURL + _endpoint + id, body: {}, token: token);
    return response.statusCode == 200;
  }
}
