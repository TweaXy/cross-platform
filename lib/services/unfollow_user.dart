import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class UnfollowUser {
  UnfollowUser._();
  final String _endpoint = 'users/follow/';
  static Future<bool>? future;
  static final instance = UnfollowUser._();
  static excute(String id, String? token) async {
    future = instance._unFollow(id, token);
  }

  Future<bool> _unFollow(String userId, String? token) async {
    var response = await Api.delete(
        url: '$baseURL$_endpoint$userId', body: {}, token: token);
    return response.statusCode == 200;
  }
}
