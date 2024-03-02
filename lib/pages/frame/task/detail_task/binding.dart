import 'package:get/get.dart';

import 'controller.dart';

class DetailTaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailTaskController>(() => DetailTaskController());
  }
}
