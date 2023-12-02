import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/user.dart';

class SearchForUsers {
  static const String _endpoint = 'users/search/';
  SearchForUsers._();
  static Future<List<User>> searchForUser(String query, String token,
      ) async {

    var response = await Api.getwithToken(
        url: '$baseURL$_endpoint$query?limit=100&offset=0', token: token);
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
}
