import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';
import 'package:tweaxy/models/notification.dart';

class GetAllNotifications {
  GetAllNotifications._();
  static const String _endpoint = '/notifications';
  static final instance = GetAllNotifications._();
  static Future<List<UserNotification>> getAllNotifications(
    int pageSize,
    int offset,
    String token,
  ) async {
    var response = await Api.getwithToken(
        url: '$baseURL$_endpoint?limit=$pageSize&offset=$offset', token: token);
    var data = response.data['data']['items'];
    List<UserNotification> notifications = [];
    for (var element in data) {
      notifications.add(UserNotification.fromJson(element));
    }
    return notifications;
  }
}
