import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/pages/frame/profile/index.dart';

class LogoutButton extends GetView<ProfileController> {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: IconButton(
          onPressed: () {
            controller.goLogout();
            controller.deleteDeviceToken();
          },
          icon: const Icon(Icons.logout)),
    );
  }
}
