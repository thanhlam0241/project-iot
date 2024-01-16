import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test1/notification/websocket_service.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:async';

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WebSocketScreen(),
//     );
//   }
// }
//
// class WebSocketScreen extends StatefulWidget {
//   @override
//   _WebSocketScreenState createState() => _WebSocketScreenState();
// }
//
// class _WebSocketScreenState extends State<WebSocketScreen> {
//
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//   late Timer timer;
//   int counter = 0;
//
//   @override
//   void initState() {
//     super.initState();
//
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid);
//
//
//
//     flutterLocalNotificationsPlugin.initialize(initializationSettings);
//
//   }
//
//   Future<void> _showNotification(String message) async {
//     var androidPlatformChannelSpecifics = AndroidNotificationDetails(
//       'your_channel_id',
//       'your_channel_name',
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//
//     var platformChannelSpecifics = NotificationDetails(
//         android: androidPlatformChannelSpecifics, iOS: null);
//
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'New WebSocket Data',
//       message,
//       platformChannelSpecifics,
//       payload: 'WebSocket Payload',
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('WebSocket Notifications'),
//       ),
//       body: Center(
//         child: Text('Listening for WebSocket data and sending integer every minute...'),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     timer.cancel(); // Cancel the timer when the screen is disposed
//     super.dispose();
//   }
// }

/*class NotificationService{
  final FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> initNotification() async{
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async{
          print(notificationResponse);
        }
    );
  }
  notificationDetails(){
    return const NotificationDetails(
      android: AndroidNotificationDetails('channelId', 'channelName',
      importance: Importance.max),
    );
  }
  Future showNotification({int id = 0, String? title, String? body, String? payLoad}) async{
    return notificationsPlugin.show(
      id, title, body, await notificationDetails()
    );

  }*/
//}
class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings initializationSettingsAndroid =
    const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification:
            (int id, String? title, String? body, String? payload) async {});

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails('channelId', 'channelName',
            importance: Importance.max),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}