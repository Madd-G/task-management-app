import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/pages/frame/home/index.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(UserStore.to.profile.username!),
            Text(UserStore.to.profile.role!),
            Text(UserStore.to.profile.email!),
            if (UserStore.to.profile.role == 'owner') const Text('owner nih'),
            TextButton(
                onPressed: () {
                  controller.goLogout();
                },
                child: const Text('Logout'))
          ],
        ),
      ),
    );
  }
}
