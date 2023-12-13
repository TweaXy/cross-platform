import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tweaxy/constants.dart';

class FirebaseApi {
  FirebaseApi._();
  static final instance = FirebaseApi._();
  //*Step 1:- Create an instance of Firebase Messaging
  static final _firebaseMessaging = FirebaseMessaging.instance;
  //*Step 2:- Create a function to initialize notifications
  static Future<void> initNotifications() async {
    //!Request Permession from user
    await _firebaseMessaging.requestPermission();
    //!Fetch the firebase messaging token for this device
    final token = await _firebaseMessaging.getToken();
    //?print the token
    print('Token = $token');
  }

  //*Step 3:- Create a function to handle received messages
  void handleMesssages(RemoteMessage? message) {
    //!If the message is null do nothing
    if (message == null) return;
    //!Navigate to new screen when message is received and user tap the notification
    navigatorKey.currentState?.pushNamed(kNotificationScreen);
  }

  //*Step 4:- Create a function to initiallize foreground and background settings
  Future initPushNotification() async {
    //!Handle notification if the app was terminated and now opened
    _firebaseMessaging.getInitialMessage().then(handleMesssages);
    //!attach Event listener for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMesssages);
  }
}
