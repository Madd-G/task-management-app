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
      UserEntity result = await UserAPI.login(params: user);
      print('result: ${result}');
      await UserStore.to.saveProfile(result);
      print('offline user: ${UserStore.to.profile.toJson()}');
      Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR);
      EasyLoading.dismiss();
    } catch (error) {
      rethrow;
    }
  }

  updateDeviceToken() async {
    String? fcmToken = await _firebaseMessaging.getToken();
    String id = state.id.value;
    var currentUser = UserStore.to.profile;
    UserEntity user = UserEntity();
    user.id = id;
    user.createdAt = currentUser.createdAt;
    user.updatedAt = currentUser.updatedAt;
    user.role = currentUser.role;
    user.username = currentUser.username;
    user.email = currentUser.email;
    user.token = currentUser.token;
    user.fcmToken = fcmToken;
    UserAPI.updateDeviceToken(params: user);
    UserStore.to.saveProfile(user);
  }
}
