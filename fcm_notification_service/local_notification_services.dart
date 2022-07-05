import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'push_notification_model.dart';

class LocalNotificationService {
  LocalNotificationService._();

  static final LocalNotificationService _instance =
      LocalNotificationService._();

  static LocalNotificationService get instance {
    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();
    return _instance;
  }

  static FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;

  late AndroidInitializationSettings androidInitializationSettings;
  late IOSInitializationSettings? iosInitializationSettings;

  // MacOSInitializationSettings initializationSettingsMacOS;
  late InitializationSettings initializationSettings;
  NotificationAppLaunchDetails? notificationAppLaunchDetails;

  bool get didNotificationLaunchApp =>
      notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

  void initializing() async {
    //Initialisation should only be done once,and this can be done is in the
    // main function of your application. Alternatively, this can be done within
    // the first page shown in your app.
    //-------------
    //initialise the plugin. app_icon needs to be a added
    // as a drawable resource to the Android head project
    // if its in drawable you don't need @drawalbe

    flutterLocalNotificationsPlugin ??= FlutterLocalNotificationsPlugin();

    //android setting init
    androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    //if in drawable
    // AndroidInitializationSettings('ic_launcher');

    //ios setting init
    iosInitializationSettings = IOSInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false,
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);

    // //MacOS setting init
    // initializationSettingsMacOS = MacOSInitializationSettings(
    //     requestAlertPermission: false,
    //     requestBadgePermission: false,
    //     requestSoundPermission: false);

    //pass init all platform setting to InitializationSettings
    initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
      // macOS: initializationSettingsMacOS,
    );

    // pass InitializationSettings to flutterLocalNotificationsPlugin
    await flutterLocalNotificationsPlugin?.initialize(
      initializationSettings,
      onSelectNotification: onSelectNotification,
    );

    notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin?.getNotificationAppLaunchDetails();
  } //end of initializing

  checkIfInitFromNotification() {
    if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
      // print(' / / / checkIfInitFromNotification is true');
      // selectedNotificationPayload = notificationAppLaunchDetails.payload;
      // initialRoute = SecondPage.routeName;
    }
  }

  Future onSelectNotification(String? payload) async {
    // print('badge count is : $badgeCount');
    // bool isAppBadgeSupported = await FlutterAppBadger.isAppBadgeSupported();
    // if (isAppBadgeSupported) {
    //   FlutterAppBadger.updateBadgeCount(++badgeCount);
    // }

    if (payload != null) {
      // print('notification payload: ' + payload);
      // if (payload == 'create_post') print('navigate to $payload');
      // navigationService.navigateTo(CreatePostViewRoute);
    }
  }

  Future onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    // return CupertinoAlertDialog(
    //   title: Text(title),
    //   content: Text(body),
    //   actions: <Widget>[
    //     CupertinoDialogAction(
    //         isDefaultAction: true,
    //         onPressed: () {
    //           print(" got pressed");
    //         },
    //         child: Text("Okay")),
    //   ],
    // );
  }

  Future showNotification(RemoteMessage message, {String? payload}) async {
    String? title, body;

    PushNotification pushNotification = PushNotification.fromMap(message.data);

    if (message.notification != null && message.notification?.title != null) {
      title = message.notification!.title!;
    } else {
      title = pushNotification.title;
    }

    if (message.notification != null && message.notification?.body != null) {
      body = message.notification!.body!;
    } else {
      body = pushNotification.body;
    }

    // print('----------------------');
    // print("params title : $title");
    // print("params body : $body");
    // print("params payload : $payload");
    // print('----------------------');

    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      // description
      importance: Importance.max,
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      channel.id,
      channel.name,
      channelDescription: channel.description,
      icon: message.notification?.android?.smallIcon,
      playSound: true,
      priority: Priority.high,
      importance: Importance.max,
      ticker: 'test',
    );

    IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
      badgeNumber: 1,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    await flutterLocalNotificationsPlugin?.show(
      message.hashCode,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
