// ignore_for_file: prefer_typing_uninitialized_variables
import 'dart:async';
import 'package:flutter/material.dart';
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

  Rx<DateTime> currentTime = DateTime.now().obs;
  Rx<DateTime> deadline = DateTime.now().obs;

  RxString timerText = ''.obs;
  late StreamSubscription<DateTime> _subscription;

  DetailTaskController() {
    _subscription =
        Stream.periodic(const Duration(seconds: 1), (i) => DateTime.now())
            .listen((DateTime time) {
      currentTime.value = time;
      updateTimerText();
    });
  }

  @override
  void onInit() {
    print('current user: ${UserStore.to.profile.toJson()}');
    state.task = Get.arguments;
    deadline = state.task.endDate!.obs;
    progress = state.task.progress.obs;
    status = state.task.status.obs;
    priority = state.task.priority.obs;
    lastUpdate = state.task.updatedAt.obs;

    if (state.task.updater != UserStore.to.profile.id) {
      TaskAPI.updateTaskIsRead(params: Task(id: state.task.id, isRead: true));
    }
    super.onInit();
  }

  void updateTimerText() {
    Duration difference = deadline.value.difference(currentTime.value);
    int hours = difference.inHours;
    int minutes = difference.inMinutes.remainder(60);
    int seconds = difference.inSeconds.remainder(60);
    timerText.value =
        '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  Future<void> showAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Task'),
          backgroundColor: Colors.white,
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Are you sure want to delete task?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Get.back();
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                TaskAPI.deleteTask(docId: state.task.id!);
                Get.back();
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
