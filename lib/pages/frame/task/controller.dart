import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'index.dart';

class TaskController extends GetxController {
  final TaskState state = TaskState();

  TaskController();

  RxString fcmToken = RxString('');

  Future<void> getEmployee(String id) async {
    var token = await UserAPI.getEmployeeFCMToken(id);
    fcmToken.value = token;
  }

  @override
  void onInit() {
    getEmployee(UserStore.to.profile.id!);
    super.onInit();
  }
}

