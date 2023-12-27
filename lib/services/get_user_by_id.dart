
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/user.dart';
import 'package:tweaxy/services/temp_user.dart';

class GetUserById {
  final String _endpoint = 'users/';
  GetUserById._();
  static final instance = GetUserById._();
  Future<User>? future;
  Future<void> excute(String id) async {
    future = getUserById(id);
  }

  Future<User> getUserById(String id) async {
    print('uuu$id');
    var response = await Api.getwithToken(
        url: baseURL + _endpoint + id, token: TempUser.token);
    var data = response.data;
    return User.fromMap(data!['data']['user']);
  }
}
