import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/temp_user.dart';

class GetBlockedUsers {
  GetBlockedUsers._();
  static const _endpoint = 'users/block/list';
  static Future<List<User>> getUsers(
      {required String username,
      required int limit,
      required int offset}) async {
    var response = await Api.getwithToken(
      url: '$baseURL$_endpoint?limit=$limit&offset=$offset',
      token: TempUser.token,
    );
    List<User> users = [];
    for (Map<String, dynamic> element in response.data['data']['mutes']) {
      users.add(
        User(
          id: element['id'],
          userName: element['username'],
          name: element['name'],
          avatar: element['avatar'],
          bio: element['bio'],
        ),
      );
    }
    return users;
  }
}
