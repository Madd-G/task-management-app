import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/routes/routes.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/pages/auth/sign_in/index.dart';

class SignInController extends GetxController {
  final SignInState state = SignInState();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  login() async {
    String id = state.id.value;
    String password = state.password.value;

    UserEntity user = UserEntity();
    user.id = id;
    user.password = password;

    try {
      EasyLoading.show(
        indicator: const CircularProgressIndicator(),
        maskType: EasyLoadingMaskType.clear,
        dismissOnTap: true,
      );
      var result = await UserAPI.login(params: user);
      await UserStore.to.saveProfile(result);
      Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
      EasyLoading.dismiss();
    } catch (error) {
      print('Error ya : $error');
    }
  }

  updateDeviceToken() async {
    String? token = await _firebaseMessaging.getToken();
    String id = state.id.value;

    UserEntity user = UserEntity();
    user.id = id;
    user.token = token;
    print('user token: ${user.token}');
    print('user toJson: ${user.token}');
    UserAPI.updateDeviceToken(params: user);
  }
}
