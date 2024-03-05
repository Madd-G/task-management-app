// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'index.dart';

class DetailTaskController extends GetxController {
  final DetailTaskState state = DetailTaskState();

  var progress;
  var status;
  var priority;
  Rx<DateTime?>? lastUpdate;

  DetailTaskController();

  @override
  void onInit() {
    state.task = Get.arguments;
    progress = state.task.progress.obs;
    status = state.task.status.obs;
    priority = state.task.priority.obs;
    lastUpdate = state.task.updatedAt.obs;
    if (state.task.updater != UserStore.to.profile.id) {
      TaskAPI.updateTaskIsRead(params: Task(id: state.task.id, isRead: true));
    }
    super.onInit();
  }
}
