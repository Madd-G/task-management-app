import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/routes/routes.dart';
import 'package:konek_mobile/common/style/style.dart';

import 'global.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}


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
