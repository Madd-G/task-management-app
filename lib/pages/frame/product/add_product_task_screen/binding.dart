import 'package:get/get.dart';

import 'controller.dart';

class AddProductTaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddProductTaskController>(() => AddProductTaskController());
  }
}
