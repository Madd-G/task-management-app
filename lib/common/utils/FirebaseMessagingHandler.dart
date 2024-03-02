import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseMessagingHandler {
  FirebaseMessagingHandler._();

  static AndroidNotificationChannel channelMessage =
      const AndroidNotificationChannel(
    'com.alamsyah.konek_mobile', // id
    'KONEK MOBILE', // title
    importance: Importance.defaultImportance,
    enableLights: true,
    playSound: true,
    // sound: RawResourceAndroidNotificationSound('alert'),
    enableVibration: true,
  );

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> config() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    try {
      await messaging.requestPermission(
        sound: true,
        badge: true,
        alert: true,
        announcement: false,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
      );

      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();
      if (initialMessage != null) {
        debugPrint("initialMessage------");
        debugPrint('$initialMessage');
      }

      var initializationSettingsAndroid =
          const AndroidInitializationSettings("ic_launcher");
      var darwinInitializationSettings = const DarwinInitializationSettings();
      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: darwinInitializationSettings,
      );
      flutterLocalNotificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (value) {});

      // for iOS
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true);

      /// when app on the foreground
      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        debugPrint("\n notification on onMessage function \n");
        debugPrint('message: ${message.notification?.body}');
        _receiveNotification(message);
      });
    } on Exception catch (e) {
      debugPrint("$e");
    }
  }

  static Future<void> _receiveNotification(RemoteMessage message) async {
    Get.snackbar(
      icon: Container(
        width: 40.0,
        height: 40.0,
        padding: const EdgeInsets.all(0.0),
        decoration: const BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.fill,
              image: NetworkImage(
                  'https://www.adidas.co.id/media/catalog/product/cache/3bec5fdb79d91223b1a151be2b21ce8d/i/n/in9367_2_hardware_photography_back_center_view_grey.jpg')),
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
      ),
      "${message.notification?.body}", // title/name
      "owner",
      duration: const Duration(seconds: 30),
      isDismissible: false,
      mainButton: TextButton(
        onPressed: () {},
        child: SizedBox(
          width: 90.0,
          child: GestureDetector(
            onTap: () {
              if (Get.isSnackbarOpen) {
                Get.closeAllSnackbars();
              }
            },
            child: Container(
              width: 40.0,
              height: 40.0,
              padding: const EdgeInsets.all(10.0),
              decoration: const BoxDecoration(
                // color: AppColors.primaryElementBg,
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              child: const Icon(
                Icons.cancel,
                color: Colors.black,
                size: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @pragma('vm:entry-point')
  static Future<void> firebaseMessagingBackground(RemoteMessage message) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint("message data: ${message.data}");
    debugPrint("message data: $message");
    debugPrint("message data: ${message.notification}");

    if (message.data["call_type"] != null) {
      if (message.data["call_type"] == "cancel") {
        FirebaseMessagingHandler.flutterLocalNotificationsPlugin.cancelAll();
        //  await setCallVoiceOrVideo(false);
        var prefs = await SharedPreferences.getInstance();
        await prefs.setString("CallVoiceOrVideo", "");
      }
      if (message.data["call_type"] == "voice" ||
          message.data["call_type"] == "video") {
        var data = {
          "to_token": message.data["token"],
          "to_name": message.data["name"],
          "to_avatar": message.data["avatar"],
          "doc_id": message.data["doc_id"] ?? "",
          "call_type": message.data["call_type"],
          "expire_time": DateTime.now().toString(),
        };
        debugPrint('$data');
        var _prefs = await SharedPreferences.getInstance();
        await _prefs.setString("CallVoiceOrVideo", jsonEncode(data));
      }
    }
  }
}
