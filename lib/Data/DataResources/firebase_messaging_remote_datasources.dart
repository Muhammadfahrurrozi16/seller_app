import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:seller_app_fic/Data/DataResources/auth_local_datasources.dart';
import 'package:seller_app_fic/Data/DataResources/auth_remote_datasources.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  FirebaseMeassagingRemoteDatasource().firebaseBackgroundHandler(message);
  
}

class FirebaseMeassagingRemoteDatasource {
  final _firebaseMessaging = FirebaseMessaging.instance;
  final flutterlocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future<void> initNotification() async{
    await _firebaseMessaging.requestPermission();

    final InitializationSettingsandroid = const AndroidInitializationSettings('ic_seller');
    final InitializationSettingsIos = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id,String ? title,String ? body,String ? payload) {
        
      }
    );

    final initiialzationSettings = InitializationSettings(
      android: InitializationSettingsandroid,
      iOS: InitializationSettingsIos
    );
    await flutterlocalNotificationsPlugin.initialize(initiialzationSettings,onDidReceiveBackgroundNotificationResponse: 
    (NotificationResponse notificationResponse) async {});
    final fcmtoken = await _firebaseMessaging.getToken();
    print('Token: $fcmtoken');

    if (await AuthLocalDatasource().isLogin()) {
      AuthRemoteDatasource().updateFcmtoken(fcmtoken ?? '');
    }

    FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.onMessage.listen((message) {
      print(message.notification?.body);
      print(message.notification?.title);
     });
     FirebaseMessaging.onMessage.listen(firebaseBackgroundHandler);
     FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
     FirebaseMessaging.onMessageOpenedApp.listen(firebaseBackgroundHandler);
  }
  Future showNotification({
    int id = 0, String? title, String? body,String? payload
  }) async {
    return flutterlocalNotificationsPlugin.show(
      id,
      title,
      body, 
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'com.example.seller_app_fic', 'seller',
          importance: Importance.max),
        iOS: DarwinNotificationDetails(),
      ));
  }
  Future<void> firebaseBackgroundHandler(RemoteMessage message) async{
    showNotification(
      title: message.notification!.title,
      body: message.notification!.body,
    );
  }
}