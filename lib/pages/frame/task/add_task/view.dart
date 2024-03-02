import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/notification.dart';
import 'package:uuid/uuid.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';

import 'index.dart';

class AddTaskPage extends GetView<AddTaskController> {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    const Uuid uuid = Uuid();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Task'),
        actions: [
          TextButton(
            onPressed: () {
              Task task = Task();
              task.id = uuid.v8();
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
              debugPrint('product toJson: ${task.toJson()}');
              controller.addTask(task);
              NotificationEntity notification = NotificationEntity();
              NotificationDetail notificationDetail = NotificationDetail(
                  title: "owner", body: controller.nameController.text);
              notification = NotificationEntity(
                  notification: notificationDetail, token: '');
              notification.token = controller.fcmToken.value;
              TaskAPI.sendNotification(notification: notification);
            },
            child: const Text('SAVE'),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: controller.addCompanyFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                CustomTextField(
                  controller: controller.nameController,
                  hintText: 'Title',
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 15.0),
                const AddCategoryDropdown(),
                const SizedBox(height: 15.0),
                SizedBox(
                  width: 700,
                  child: CustomTextField(
                    controller: controller.descriptionController,
                    hintText: 'Description',
                    keyboardType: TextInputType.text,
                    maxLines: 10,
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  width: 700,
                  child: CustomTextField(
                    controller: controller.weightController,
                    hintText: 'Weight',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 15.0),
                const AddStatusDropdown(),
                const SizedBox(height: 15.0),
                const AddPriorityDropdown(),
                const SizedBox(height: 15.0),
                const AddAssigneeDropdown(),
                const SizedBox(height: 15.0),
                DateTimeRow(
                  title: 'Start Date',
                  dateTime: controller.startDate,
                  onPressed: () =>
                      controller.dateTimePickerWidget(context, "start date"),
                ),
                const SizedBox(height: 15.0),
                DateTimeRow(
                  title: 'End Date',
                  dateTime: controller.endDate,
                  onPressed: () =>
                      controller.dateTimePickerWidget(context, "end date"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
