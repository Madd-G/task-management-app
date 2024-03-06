import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/pages/frame/task/add_task/index.dart';
import 'package:uuid/uuid.dart';

class SaveButton extends GetView<AddTaskController> {
  const SaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    const Uuid uuid = Uuid();
    return TextButton(
      onPressed: () async {
        String id = uuid.v8();
        if (controller.addCompanyFormKey.currentState!.validate()) {
          await controller.uploadFile(controller.imageFile, id);
          Task task = Task();
          task.id = id;
          task.name = controller.nameController.text;
          task.category = controller.category.value;
          task.weight = num.parse(controller.weightController.text);
          task.status = controller.status.value;
          task.startDate = controller.startDate?.value;
          task.endDate = controller.endDate?.value;
          task.assignee = controller.employeeName.value;
          task.target = controller.employeeRole.value;
          task.description = controller.descriptionController.text;
          task.progress = 0;
          task.priority = controller.priority.value;
          task.imageUrl = controller.imageUrl.value;
          task.updater = controller.employeeName.value;
          controller.addTask(task);
          if (controller.fcmToken?.value != '') {
            NotificationEntity notification = NotificationEntity();
            NotificationDetail notificationDetail = NotificationDetail(
                title: "owner", body: controller.nameController.text);
            notification =
                NotificationEntity(notification: notificationDetail, token: '');
            notification.token = controller.fcmToken?.value;
            TaskAPI.sendNotification(notification: notification);
          }
        }
      },
      child: const Text('SAVE'),
    );
  }
}
