//Todo ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'notification_services.dart';

class FirebaseMessage {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  void request_permission() async {
    NotificationSettings settings = await _messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      AppSettings.openAppSettings(type: AppSettingsType.notification);
      print('User declined or has not accepted permission');
    }
  }

  firebase_init() {
    FirebaseMessaging.onMessage.listen((event) {
      print('Received message::::::::::::: ${event.data}');
      print('Received title:::::::::::::::::::: ${event.notification!.title}');
      print('Received body::::::::::::::::::::: ${event.notification!.body}');
      Future.delayed(const Duration(seconds: 1)).then((s) {
        NotificationService().showNotification(event);
      });
    });
  }

  Future get_token() async {
    String? token = await _messaging.getToken();
    print(token);
    return token;
  }

  void refresh_token() async {
    _messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('Token refreshed: $event');
    });
  }
}
