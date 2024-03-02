import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'index.dart';

class DetailTaskController extends GetxController {
  final DetailTaskState state = DetailTaskState();

  var  progress;
  var status;
  var priority;
  Rx<DateTime?>? lastUpdate;

  DetailTaskController();

  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  //
  // void getToken() async {
  //   String? token = await _firebaseMessaging.getToken();
  // }

  @override
  void onInit() {
    print('onInit');
    state.task = Get.arguments;
    progress = state.task.progress.obs;
    status = state.task.status.obs;
    priority = state.task.priority.obs;
    lastUpdate = state.task.updatedAt.obs;
    print('task: ${state.task}');
    // getToken();
    super.onInit();
  }
}
