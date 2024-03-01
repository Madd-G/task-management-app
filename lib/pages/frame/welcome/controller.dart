import 'package:get/get.dart';
import 'package:konek_mobile/common/routes/routes.dart';

import 'index.dart';

class WelcomeController extends GetxController {
  final state = WelcomeState();

  @override
  void onReady() {
    super.onReady();
    Future.delayed(
        const Duration(seconds: 1), () => Get.offAllNamed(AppRoutes.BOTTOM_NAV_BAR));
  }
}
