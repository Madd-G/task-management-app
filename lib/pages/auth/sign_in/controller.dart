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
}
