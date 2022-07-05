//
//
// import 'package:dio/dio.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:get_storage/get_storage.dart';
// import 'package:path_provider/path_provider.dart';
// import 'dart:io' show File, Platform;
// import 'package:rxdart/subjects.dart';
//
// import '../../language_and_localization/app_language_controller.dart';
//
// class NotificationPlugin {
//   //
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin=FlutterLocalNotificationsPlugin();
//   final BehaviorSubject<ReceivedNotification>
//   didReceivedLocalNotificationSubject =
//   BehaviorSubject<ReceivedNotification>();
//   InitializationSettings? initializationSettings;
//
//   NotificationPlugin._() {
//     init();
//   }
//
//   init() async {
//     flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//     if (Platform.isIOS) {
//       _requestIOSPermission();
//     }
//     initializePlatformSpecifics();
//   }
//
//   initializePlatformSpecifics()async {
//     var initializationSettingsAndroid =
//     AndroidInitializationSettings('@drawable/ic_launcher',);
//     var initializationSettingsIOS = IOSInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: false,
//       onDidReceiveLocalNotification: (id, title, body, payload) async {
//         ReceivedNotification receivedNotification = ReceivedNotification(
//             id: id, title: title!, body: body!, payload: payload!);
//         didReceivedLocalNotificationSubject.add(receivedNotification);
//       },
//     );
//
//     initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     flutterLocalNotificationsPlugin.initialize(initializationSettings!,
//         onSelectNotification:  (String? payload) async {
//           if(payload!='null') {
//             debugPrint("InitializationSettings");
//           }
//         });
//
//
//
//   }
//
//   _requestIOSPermission() {
//     flutterLocalNotificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         IOSFlutterLocalNotificationsPlugin>()
//         !.requestPermissions(
//       alert: false,
//       badge: true,
//       sound: true,
//     );
//   }
//
//   setListenerForLowerVersions(Function onNotificationInLowerVersions) {
//     didReceivedLocalNotificationSubject.listen((receivedNotification) {
//       onNotificationInLowerVersions(receivedNotification);
//     });
//   }
//
//   onNotificationClick(String requestId) {
//     debugPrint('+++++++++++++++++++++++++++++++++   onNotificationClick  requestId:$requestId');
//     onClick(requestId: requestId);
//   }
//
//
//
//
//   onClick({String? requestId})async {
//
//
//     debugPrint('+++++++++++++++++++++++++++++++++   onClick  requestId:$requestId');
//
//     debugPrint("this is payload");
//     // Get.toNamed(Routes.SERVICES);
//
//     // Navigator.push(context, MaterialPageRoute(builder: (coontext) {
//     //   return NotificationScreen(
//     //     payload: payload,
//     //   );
//     // }));
//
//   }
//
//   setOnNotificationClick(Function onNotificationClick) async {
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings!,
//       onSelectNotification: (String? payload) async {
//         //   onNotificationClick(payload);
//         onClick(requestId:payload );
//         debugPrint("+++++++++++++++++++++++++++++++++++++++++++    clicked    $payload");
//       },
//
//     );
//   }
//
//   Future<void> showNotification(RemoteMessage message) async {
//     // if(flutterLocalNotificationsPlugin==null){
//     //   init();
//     // }
//     try {
//       AndroidNotificationChannel channel = AndroidNotificationChannel(
//         'high_importance_channel', // id
//         'High Importance Notifications', // title
//         description: 'This channel is used for important notifications.',// description
//         importance: Importance.max,
//         playSound: true,
//
//       );
//       String locale = await GetStorage().read(Get.find<AppLanguage>().languageCodeKey);
//       ReceivedNotification receivedNotification = ReceivedNotification(
//           id: message.hashCode,
//           title:  locale.toString()=='ar'? message.data['titleAr']:message.data['titleEn'],
//           body:  locale.toString()=='ar'? message.data['bodyAr']:message.data['bodyEn'],
//           payload: 'payload',
//           requestId: message.data['type']=='AcceptRequest'?message.data['requestId']:'null' ,
//
//       );
//       flutterLocalNotificationsPlugin.show(
//         message.hashCode,
//         receivedNotification.title,
//         receivedNotification.body,
//         NotificationDetails(
//           android: AndroidNotificationDetails(
//             channel.id,
//             channel.name,
//               channelDescription: channel.description,
//             channelShowBadge:true,
//             importance: Importance.max,
//             priority: Priority.max,
//             playSound: true,
//             icon: "@mipmap/ic_launcher",
//               showWhen: true,
//               styleInformation: BigTextStyleInformation(
//                 receivedNotification.body!,
//               )
//             // other properties...
//           ),
//         ),
//         payload: message.data['type']=='AcceptRequest'?message.data['requestId']:'null' ,
//
//       );
//     }catch(e,er){
//       print(er);
//     }
//
//
//   }
//
//   Future<void> showDailyAtTime() async {
//     var time = Time(21, 3, 0);
//     var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL_ID 4',
//       'CHANNEL_NAME 4',
//    channelDescription:    "CHANNEL_DESCRIPTION 4",
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics =
//     NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
//     await flutterLocalNotificationsPlugin.showDailyAtTime(
//       0,
//       'Test Title at ${time.hour}:${time.minute}.${time.second}',
//       'Test Body', //null
//       time,
//       platformChannelSpecifics,
//       payload: 'Test Payload',
//     );
//   }
//
//   Future<void> showWeeklyAtDayTime() async {
//     var time = Time(21, 5, 0);
//     var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL_ID 5',
//       'CHANNEL_NAME 5',
//      channelDescription:  "CHANNEL_DESCRIPTION 5",
//       importance: Importance.max,
//       priority: Priority.high,
//     );
//     var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics =
//     NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
//     await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
//       0,
//       'Test Title at ${time.hour}:${time.minute}.${time.second}',
//       'Test Body', //null
//       Day.saturday,
//       time,
//       platformChannelSpecifics,
//       payload: 'Test Payload',
//     );
//   }
//
//   Future<void> repeatNotification() async {
//     var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL_ID 3',
//       'CHANNEL_NAME 3',
//       channelDescription: "CHANNEL_DESCRIPTION 3",
//       importance: Importance.max,
//       priority: Priority.high,
//       styleInformation: DefaultStyleInformation(true, true),
//     );
//     var iosChannelSpecifics = IOSNotificationDetails();
//     var platformChannelSpecifics =
//     NotificationDetails(android: androidChannelSpecifics, iOS: iosChannelSpecifics);
//     await flutterLocalNotificationsPlugin.periodicallyShow(
//       0,
//       'Repeating Test Title',
//       'Repeating Test Body',
//       RepeatInterval.everyMinute,
//       platformChannelSpecifics,
//       payload: 'Test Payload',
//     );
//   }
//
//   Future<void> scheduleNotification() async {
//     var scheduleNotificationDateTime = DateTime.now().add(Duration(seconds: 5));
//     var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL_ID 1',
//       'CHANNEL_NAME 1',
//       channelDescription: "CHANNEL_DESCRIPTION 1",
//       icon: 'secondary_icon',
//       sound: RawResourceAndroidNotificationSound('my_sound'),
//       largeIcon: DrawableResourceAndroidBitmap('large_notf_icon'),
//       enableLights: true,
//       color: const Color.fromARGB(255, 255, 0, 0),
//       ledColor: const Color.fromARGB(255, 255, 0, 0),
//       ledOnMs: 1000,
//       ledOffMs: 500,
//       importance: Importance.max,
//       priority: Priority.high,
//       playSound: true,
//       timeoutAfter: 5000,
//       styleInformation: DefaultStyleInformation(true, true),
//     );
//     var iosChannelSpecifics = IOSNotificationDetails(
//       sound: 'my_sound.aiff',
//     );
//     var platformChannelSpecifics = NotificationDetails(
//       android: androidChannelSpecifics,
//       iOS: iosChannelSpecifics,
//     );
//     await flutterLocalNotificationsPlugin.schedule(
//       0,
//       'Test Title',
//       'Test Body',
//       scheduleNotificationDateTime,
//       platformChannelSpecifics,
//       payload: 'Test Payload',
//     );
//   }
//
//   Future<void> showNotificationWithAttachment() async {
//     var attachmentPicturePath = await _downloadAndSaveFile(
//         'https://via.placeholder.com/800x200', 'attachment_img.jpg');
//     var iOSPlatformSpecifics = IOSNotificationDetails(
//       attachments: [IOSNotificationAttachment(attachmentPicturePath)],
//     );
//     var bigPictureStyleInformation = BigPictureStyleInformation(
//       FilePathAndroidBitmap(attachmentPicturePath),
//
//       contentTitle: '<b>Attached Image</b>',
//       htmlFormatContentTitle: true,
//       summaryText: 'Test Image',
//       htmlFormatSummaryText: true,
//     );
//     var androidChannelSpecifics = AndroidNotificationDetails(
//       'CHANNEL ID 2',
//       'CHANNEL NAME 2',
//       channelDescription: 'CHANNEL DESCRIPTION 2',
//       importance: Importance.high,
//       priority: Priority.high,
//       styleInformation: bigPictureStyleInformation,
//
//     );
//     var notificationDetails =
//     NotificationDetails(android: androidChannelSpecifics, iOS: iOSPlatformSpecifics);
//     await flutterLocalNotificationsPlugin.show(
//       0,
//       'Title with attachment',
//       'Body with Attachment',
//       notificationDetails,
//     );
//   }
//
//   _downloadAndSaveFile(String url, String fileName) async {
//     var directory = await getApplicationDocumentsDirectory();
//     var filePath = '${directory.path}/$fileName';
//     var response = await Dio().get(url);
//     var file = File(filePath);
//     await file.writeAsBytes(response.data);
//     return filePath;
//   }
//
//   Future<int> getPendingNotificationCount() async {
//     List<PendingNotificationRequest> p =
//     await flutterLocalNotificationsPlugin.pendingNotificationRequests();
//     return p.length;
//   }
//
//   Future<void> cancelNotification() async {
//     await flutterLocalNotificationsPlugin.cancel(0);
//   }
//
//   Future<void> cancelAllNotification() async {
//     await flutterLocalNotificationsPlugin.cancelAll();
//   }
// }
//
// NotificationPlugin notificationPlugin = NotificationPlugin._();
//
// class ReceivedNotification {
//   final int? id;
//   final String? title;
//   final String? body;
//   final String ?payload;
//   final String ?requestId;
//
//   ReceivedNotification({
//  this.id,
//    this.title,
//    this.body,
//    this.payload,
//    this.requestId
//   });
// }
