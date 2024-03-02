import 'package:get/get.dart';
import 'index.dart';

class DetailTaskController extends GetxController {
  final DetailTaskState state = DetailTaskState();

  var  progress;
  var status;
  var priority;
  Rx<DateTime?>? lastUpdate;

  DetailTaskController();
  @override
  void onInit() {
    print('onInit');
    state.task = Get.arguments;
    progress = state.task.progress.obs;
    status = state.task.status.obs;
    priority = state.task.priority.obs;
    lastUpdate = state.task.updatedAt.obs;
    print('task: ${state.task}');
    super.onInit();
  }
}
