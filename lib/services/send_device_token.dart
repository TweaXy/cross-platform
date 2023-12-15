import 'package:tweaxy/constants.dart';
import 'package:tweaxy/helpers/api.dart';

class SendDeviceToken {
  SendDeviceToken._();
  static const String _endpoint = '/notifications/deviceTokenAndorid';
  static final instance = SendDeviceToken._();
  static Future<void> getAllNotifications(
    String? userToken,
    String? notificationToken,
  ) async {
    await Api.post(
      url: baseURL + _endpoint,
      token: userToken,
      body: {
        'token': notificationToken,
      },
    );
  }
}
