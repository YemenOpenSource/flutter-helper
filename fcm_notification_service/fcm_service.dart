import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'local_notification_services.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  /// If you're going to use other Firebase services in the background, such as Firestore,
  /// make sure you call `initializeApp` before using other Firebase services.
  // await Firebase.initializeApp();
  // print("==>Handling a background message.id: ${message?.messageId}");
  // print("message.data == >: ${message?.data}");
  // print("message.notification.title == >: ${message?.notification?.title}");
  // print("message.notification.body == >: ${message?.notification?.body}");
  if (message.notification == null) {
    LocalNotificationService.instance.showNotification(message);
  }
}

class PushNotificationService {
  PushNotificationService._();

  static final PushNotificationService _instance = PushNotificationService._();

  static PushNotificationService get instance => _instance;

  ///...........................

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  final LocalNotificationService _localNotification =
      LocalNotificationService.instance;

  // var _lastOnResumeCall = DateTime.now().microsecondsSinceEpoch;

  Future<String?> getToken() async {
    String? fcmToken = await _fcm.getToken();
    debugPrint('fcm token is ====>');
    debugPrint(fcmToken);
    debugPrint('========');
    return fcmToken;
  }

  initialise(bool hasInternetConnection) async {
    // init local
    _localNotification.initializing();

    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      // print('User granted permission');
    }
    else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      // print('User granted provisional permission');
    } else {
      // print('User declined or has not accepted permission');
    }

    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    await _fcmConfig();

    // if (hasInternetConnection) {
    //   await subscribeToAllNotification();
    // }
  }

  _fcmConfig() async {
    //--- 1
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //--- 2
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      // print('==> Got a message whilst in the foreground! (onMessage)');
      // print('Message data: ${message.data}');

      await _localNotification.showNotification(message);
    });
    //3 =>onOpenFromTerminatedState
    onOpenFromTerminatedState();
  }

  // subscribeToAllNotification() async {
  //   await _fcm
  //       .subscribeToTopic('topic name');
  // }

  onOpenFromTerminatedState() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      // print('=====> initialMessage');
      // print('=====> iniMessage.data ===>  ${initialMessage.data} //end');
      // print(
      //     'initMessage.notification.title ===>  ${initialMessage.notification?.title}');
      // print(
      //     'initMessage.notification.body ===>  ${initialMessage.notification?.body}');
      // If the message also contains a data property with a "type" of "chat",
      // navigate to a chat screen
      // if (initialMessage?.data['type'] == 'chat') {
      //   // Navigator.pushNamed(context, '/chat',
      //   //     arguments: ChatArguments(initialMessage));
      // }
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // print('=====> onMessageOpenedApp');
      // print('=====> message.data ===>  ${message.data} //end');
      // print('message.notification.title ===>  ${message.notification.title}');
      // print('message.notification.body ===>  ${message.notification.body}');
      // if (message.data['type'] == 'chat') {
      //   Navigator.pushNamed(context, '/chat',
      //       arguments: ChatArguments(message));
      // }
    });
  }

// Future<void> sendPushMessage(
//     String toFcmToken, String userName, String clubId) async {
//   final Dio _dio = new Dio();
//
//   String token =
//       'key=AAAA8BtBFGA:APA91bHZtvlGOqmfCokNZCAxtZr0uRXpMlwt1rZ_sggsGH-ODm4O9CULEeK_GsqeQPIVAe7GOScOPlDo-3BMifkEDuYYOHcYDpnXyVsUmNOkkmUVjTVlJxUwyKA4LV2D9IIawpETM4FZ';
//
//   var dataToSend = {
//     "notification": {
//       "title": "New join Request",
//       "body": "$userName request to join your club",
//     },
//     "priority": "high",
//     "data": {
//       "click_action": "FLUTTER_NOTIFICATION_CLICK",
//       "id": "1",
//       "status": "done",
//       "clubId": clubId,
//     },
//     "to": toFcmToken,
//   };
//
//   try {
//     print('////////start send notification data');
//     Response response = await _dio.post("https://fcm.googleapis.com/fcm/send",
//         data: dataToSend,
//         options: Options(
//             contentType: Headers.jsonContentType,
//             headers: {'Authorization': token}));
//
//     print(response.toString());
//
//     if (response.statusCode == 200) {
//       // dynamic data = response.data;
//       // var decodedJsonData = jsonDecode(jsonEncode(data));
//     }
//   } on DioError catch (error) {
//     print('====> catch error in Sending Notification');
//     print(error?.response?.data?.toString());
//     if (error.response.data != null) {
//       return error.response.data;
//     } else {
//       return AppStrings.unexpectedError;
//     }
//   }
// }
}
