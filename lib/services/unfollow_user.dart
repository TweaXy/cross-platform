import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class UnfollowUser {
  UnfollowUser._();
  final String _endpoint = 'users/follow/';
  static final instance = UnfollowUser._();
  Future<bool> unFollow(String userId, String token) async {
    var response = await Api.delete(
        url: '$baseURL$_endpoint$userId', body: {}, token: token);
    return response.statusCode == 200;
  }
}
