import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/routes/routes.dart';
import 'package:konek_mobile/common/style/style.dart';

import 'common/apis/notification_service.dart';
import 'global.dart';

Future<void> main() async {
  await Global.init();
  NotificationService.sendNotification(notificationData);

  runApp(const MyApp());
}

final notificationData = {
  "notification": {
    "title": "Hello from Devfest!",
    "body": "Thank you for attending this talk"
  },
  "token":
      "fE02ReNlQH6OMjT0yrfDFb:APA91bH7hSJ1wE9bVUW4mKoZF2mzBelNUPZtUNTaL2ybplAOfMijfp_oQ_Au8T0O5bZamqy-w432SJUNYiybK3eFAQ_H3egkum2D3LN8eh5PB6z2xzAEIKuOoJjcGdwdLHTnqY6dbcFV",
};

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      color: AppColor.scaffoldBackground,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      builder: EasyLoading.init(),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      defaultTransition: Transition.noTransition,
    );
  }
}
