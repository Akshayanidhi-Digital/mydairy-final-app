import 'dart:io';
import 'dart:math';

import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mydairy/export.dart';

void backgroundNotificationResponseHandler(
    NotificationResponse notification) async {
  try {
    print("notification response: ${notification.payload}");
  } catch (e) {
    print("notification response error: ${e.toString}");
  }
  print('Received background notification response: $notification');
}

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    await notificationPlugin.initialize(
        const InitializationSettings(
            android: AndroidInitializationSettings('logo')),
        onDidReceiveNotificationResponse: (payload) {},
        onDidReceiveBackgroundNotificationResponse:
            backgroundNotificationResponseHandler);
  }

  Future<void> showNotification(RemoteMessage message
      // {int id = 0, String? title, String? body, String? payload}
      ) async {
    // print('Showing notification: $id, $title, $body, $payload');
    // AndroidNotificationChannel channel = AndroidNotificationChannel(
    //     Random.secure().nextInt(100000).toString(),
    //     'Higi Impotance Notifications',
    //     importance: Importance.max);

    // AndroidNotificationDetails androidNotificationDetails =
    //     AndroidNotificationDetails(
    //         channel.id.toString(), channel.name.toString(),
    //         channelDescription: 'Your chanel description',
    //         importance: Importance.high,
    //         priority: Priority.high,
    //         ticker: 'ticker');

    await notificationPlugin.show(
      0, message.notification!.title.toString(),
      message.notification!.body.toString(),
      await notificationDetails(message),
      // payload: payload
    );
  }

  int notify = 0;
  Future<NotificationDetails> notificationDetails(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        playSound: true,
        Random.secure().nextInt(100000).toString(),
        'Higi Impotance Notifications',
        importance: Importance.max);
    notify++;
    print('Notification number::::::::::::::::::::::::::::::::::: $notify');
    print("id:::::::::::::: ${channel.id}");
    print("data:::::::::::: ${message.data}");
    // print("body-msg:::::::::::: ${message.notification!.body}");

    return NotificationDetails(
        iOS: const DarwinNotificationDetails(),
        android: AndroidNotificationDetails(
          channel.id.toString(),
          // message.notification!.title.toString(),
          message.notification!.body.toString(),
          importance: Importance.max,
          priority: Priority.high,
          colorized: true,
          color: AppColor.appColor,
          autoCancel: true,
          fullScreenIntent: true,
          styleInformation: await image_file(message),
          // actions: [
          //   const AndroidNotificationAction("1", "Cancel",
          //       cancelNotification: true),
          //   AndroidNotificationAction(
          //       titleColor: AppColor.greenClr,
          //       "2",
          //       "Accept",
          //       inputs: [
          //         const AndroidNotificationActionInput(
          //             choices: ["Yes", "No"],
          //             label: "Message",
          //             allowFreeFormInput: true)
          //       ])
          // ],
        ));
  }

  image_file(RemoteMessage message) async {
    if (message.notification == null) {
      return null;
    } else if (message.notification!.android == null) {
      return null;
    } else if (message.notification!.android!.imageUrl != null) {
      return BigPictureStyleInformation(
        FilePathAndroidBitmap(await downloadAndSaveImage(
            message.notification!.android!.imageUrl.toString())),
        // contentTitle: message.notification!.title.toString(),
        htmlFormatContentTitle: true,
        htmlFormatSummaryText: true,
      );
    } else {
      return null;
    }
  }

  downloadAndSaveImage(String imageUrl) async {
    final response = await http.get(Uri.parse(imageUrl));
    final documentDirectory = await getTemporaryDirectory();
    final filePath = '${documentDirectory.path}/notification_image.jpg';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }
}

final notificationApiProvider = FutureProvider.autoDispose((ref) async {
  return NotificationApi(ref).notification();
});

class NotificationApi {
  Ref ref;
  NotificationApi(this.ref);
  Future notification() async {
    final response =
        await ApiMethod(ref: ref).postDioRequest(Url.notification_dairy);
    if (response.success == true) {
      return response.data;
    } else {
      errorSnacMsg(response);
    }
  }
}
