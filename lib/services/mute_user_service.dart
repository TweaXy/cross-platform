
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/services/temp_user.dart';

class MuteUserService {
  MuteUserService._();
  static const _endpoint = 'users/mute/';
  static Future<bool> mute({required String username}) async {
    var response = await Api.post(
        url: '$baseURL$_endpoint$username', body: {}, token: TempUser.token);
    if (response is String) {
      return false;
    }
    return true;
  }

  static Future<bool> unMuteUser({required String username}) async {
    try {
      await Api.delete(
          url: '$baseURL$_endpoint$username', body: {}, token: TempUser.token);
      return true;
    } catch (e) {
      return false;
    }
  }
}
