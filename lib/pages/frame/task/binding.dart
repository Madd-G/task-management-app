import 'package:get/get.dart';

import 'controller.dart';

class TaskBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<TaskController>(TaskController());
  }
}
