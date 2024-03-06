import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';

import 'index.dart';

class AddTaskPage extends GetView<AddTaskController> {
  const AddTaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Task'),
        actions: const [SaveButton()],
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
                  overrideValidator: false,
                ),
                const SizedBox(height: 15.0),
                const AddCategoryDropdown(),
                const SizedBox(height: 15.0),
                CustomTextField(
                  controller: controller.descriptionController,
                  hintText: 'Description',
                  keyboardType: TextInputType.text,
                  maxLines: 10,
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Row(
                        children: [
                          const Text('image: '),
                          Obx(() => Expanded(
                                  child: Text(
                                controller.imageName.value,
                                maxLines: 2,
                              ))),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _showPicker(context);
                      },
                      child: const Icon(Icons.camera_alt),
                    ),
                  ],
                ),
                const SizedBox(height: 15.0),
                CustomTextField(
                  controller: controller.weightController,
                  hintText: 'Weight',
                  keyboardType: TextInputType.number,
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

  void _showPicker(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('Gallery'),
                  onTap: () {
                    controller.imgFromGallery();
                    Navigator.pop(bc);
                  }),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  controller.imgFromCamera();
                  Navigator.pop(bc);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
