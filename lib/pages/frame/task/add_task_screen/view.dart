import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/pages/frame/task/add_task_screen/widgets/widgets.dart';
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
              Task product = Task();
              product.id = uuid.v8();
              product.name = controller.nameController.text;
              product.category = controller.category.value;
              product.weight = num.parse(controller.weightController.text);
              product.status = controller.status.value;
              product.startDate = controller.startDate?.value;
              product.endDate = controller.endDate?.value;
              product.assignee = controller.employeeName.value;
              product.target = controller.employeeRole.value;
              debugPrint('product toJson: ${product.toJson()}');
              controller.addTask(product);
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
                SizedBox(
                  width: 700,
                  child: CustomTextField(
                    controller: controller.nameController,
                    hintText: 'Username',
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 15.0),
                const CategoryDropdown(),
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
                const StatusDropdown(),
                const SizedBox(height: 15.0),
                const AssigneeDropdown(),
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
