import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'index.dart';

class WelcomePage extends GetView<WelcomeController> {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.scaffoldBackground,
      body: SizedBox(
        width: 360.0,
        height: 780.0,
        child: Container(
          margin: const EdgeInsets.only(top: (310 + 44.0)),
          child: Text(
            controller.state.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColor.primaryText,
              fontWeight: FontWeight.bold,
              fontSize: 45,
            ),
          ),
        ),
      ),
    );
  }
}
