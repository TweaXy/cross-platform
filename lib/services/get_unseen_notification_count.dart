import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class GetUnseenNotificationCount {
  GetUnseenNotificationCount._();
  static const String _endpoint = 'notification/unseenNotification';
  static final instance = GetUnseenNotificationCount._();
  static Future<int> getUnseenNotificationCount(
    String token,
  ) async {
    var response =
        await Api.getwithToken(url: '$baseURL$_endpoint', token: token);
    int data = response.data['data']['count'];
    print('Count = $data');
    return data;
  }
}
