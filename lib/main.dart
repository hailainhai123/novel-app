import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:novel_app_client/arbe_module/api/custom_log.dart';
import 'package:novel_app_client/constant/icons_path.dart';
import 'package:novel_app_client/constant/routes.dart';
import 'package:novel_app_client/models/user_infomation.dart';
import 'package:novel_app_client/utils/global_controller.dart';

import 'arbe_module/utils/user_pref.dart';
import 'binding/app_binding.dart';
import 'constant/theme.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp();
  debugPrint('Handling a background message ${message.data}');
  debugPrint('Handling a background message ${message.notification}');
  RemoteNotification? notification = message.notification;
  AndroidNotification? android = message.notification?.android;
  // CustomLog.log(message.notification.title);
  CustomLog.log('Got a message whilst in the foreground!');
  CustomLog.log('Message data: ${message.data}');
  if (message.notification != null) {
    CustomLog.log(
        'Message also contained a notification: ${message.notification}');
  }

  if (notification != null && android != null) {
    flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            // TODO add a proper drawable resource to android, for now using
            //      one that already exists in example app.
            icon: 'launch_background',
          ),
        ));
  }
}

class ReceivedNotification {
  ReceivedNotification({
    required this.id,
    required this.title,
    required this.body,
    required this.payload,
  });

  final int id;
  final String? title;
  final String? body;
  final String? payload;
}

// String? selectedNotificationPayload;

AndroidNotificationChannel channel = const AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // titletion
  importance: Importance.max,
);

void main() async {
  await GetStorage.init();
  UserPref().call();
  WidgetsFlutterBinding.ensureInitialized();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  if (kReleaseMode) {
    CustomImageCache();
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  final globalController = Get.put(GlobalController(), permanent: true);
  bool finish = false;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> initializeDefault() async {
    FirebaseApp app = await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/launcher_icon');
    final IOSInitializationSettings initializationSettingsIOS =
        IOSInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false,
            onDidReceiveLocalNotification: (
              int id,
              String? title,
              String? body,
              String? payload,
            ) async {
              gotoScreen();
            });
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      if (payload != null) {
        debugPrint('notification payload: $payload');
      }
      gotoScreen();
    });
    User? user = FirebaseAuth.instance.currentUser;
    String? token = await user?.getIdToken(true);
    globalController.setToken(token ?? "");
    CustomLog.log('Initialized default app $app');
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    debugPrint('User granted permission: ${settings.authorizationStatus}');
    String topic = kReleaseMode ? 'notification' : 'notification_dev';
    await messaging.subscribeToTopic(topic);
    final fcmToken = await FirebaseMessaging.instance.getToken();

    // globalController.setFCMToken(fcmToken ?? "");
    CustomLog.log("fcmToken =======> $fcmToken");

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: false,
      sound: true,
    );

    //TODO: Bật tắt thông báo trong App
    // final bool? enableNotification = await SessionPrefs.getEnableNotification();
    // if (enableNotification != null && enableNotification) {
    //   await messaging.subscribeToTopic("notification");
    // } else {
    //   await messaging.unsubscribeFromTopic("notification");
    // }

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) async {
      if (message != null) {
        CustomLog.log('Message trong app nhận về ${message.toString()}');
        globalController.setBookId(message.data['bookId']);
        gotoScreen();
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint("onMessageOpenedApp: ${message.data}");
      CustomLog.log('Message khi ở app  ${message.toString()}');
      globalController.setBookId(message.data['bookId']);
      gotoScreen();
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      // CustomLog.log(message.notification.title);
      CustomLog.log('Got a message whilst in the foreground!');
      CustomLog.log('Message data: ${message.data}');
      globalController.setBookId(message.data['bookId']);

      if (message.notification != null) {
        CustomLog.log(
            'Message also contained a notification: ${message.notification}');
      }

      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                // TODO add a proper drawable resource to android, for now using
                //      one that already exists in example app.
                icon: 'launch_background',
              ),
            ));
      }
    });
    return;
  }

  void gotoScreen() {
    if (globalController.bookIdFromNotification == "") {
      Get.toNamed(kNotificationPage);
    } else {
      Get.toNamed(kBookDetails,
          parameters: {'id': globalController.bookIdFromNotification});
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final UserInformation prefUser = UserPref().getUser();
    return FutureBuilder<void>(
        future: initializeDefault(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
              child: Center(
                child: SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(IconsPath.logo)),
                ),
              ),
            );
          } else {
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return GetMaterialApp(
                smartManagement: SmartManagement.onlyBuilder,
                title: 'Truyện 3K',
                theme: lightTheme(),
                initialBinding: GlobalBinding(),
                debugShowCheckedModeBanner: false,
                getPages: pages,
                builder: EasyLoading.init(),
                initialRoute: kRouteIndex,
              );
            }
          }
        });
  }
}

class CustomImageCache extends WidgetsFlutterBinding {
  @override
  ImageCache createImageCache() {
    ImageCache imageCache = super.createImageCache();
    imageCache.maximumSizeBytes = 2048 * 2048 * 400;
    return imageCache;
  }
}
