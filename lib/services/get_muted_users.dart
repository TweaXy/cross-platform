import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/temp_user.dart';

class GetMutedUsers {
  GetMutedUsers._();
  static const _endpoint = 'users/mute/list';
  static Future<List<User>> getUsers(
      {required int limit, required int offset}) async {
    var response = await Api.getwithToken(
      url: '$baseURL$_endpoint?limit=$limit&offset=$offset',
      token: TempUser.token,
    );
    print(response.data);
    List<User> users = [];
    for (Map<String, dynamic> element in response.data['data']['mutes']) {
      users.add(
        User(
          id: element['id'],
          userName: element['username'],
          name: element['name'],
          avatar: element['avatar'],
          bio: element['bio'],
          followedByMe: element['followedByMe'],
        ),
      );
    }
    return users;
  }
}
