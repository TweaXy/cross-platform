import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/user.dart';

class GetUserById {
  final String _endpoint = 'users/';
  GetUserById._();
  static final instance = GetUserById._();
  Future<User> getUserById(String id) async {
    var response = await Api.get(baseURL + _endpoint + id);
    var data = response.data;
    return User.fromMap(data);
  }
}
