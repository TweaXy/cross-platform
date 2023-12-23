import 'package:shared_preferences/shared_preferences.dart';
import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class GetUnseenNotificationCount {
  GetUnseenNotificationCount._();
  static const String _endpoint = 'notification/unseenNotification';
  static final instance = GetUnseenNotificationCount._();
  static Stream<int> getUnseenNotificationCount(
  ) async* {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('token');
    var response =
        await Api.getwithToken(url: '$baseURL$_endpoint', token: token);
    int data = response.data['data']['notificationCount'];
    print('Count = $data');
    yield data;
  }
}
