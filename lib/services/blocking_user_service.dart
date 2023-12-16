import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/services/temp_user.dart';

class BlockingUserService {
  BlockingUserService._();
  static const _endpoint = 'users/block/';
  static Future<bool> blockUser({required String username}) async {
    var response = await Api.post(
        url: '$baseURL$_endpoint$username', body: {}, token: TempUser.token);
    if (response is String) {
      return false;
    }
    return true;
  }

  static Future<bool> unBlockUser({required String username}) async {
    try {
      await Api.delete(
          url: '$baseURL$_endpoint$username', body: {}, token: TempUser.token);
      return true;
    } catch (e) {
      return false;
    }
  }
}
