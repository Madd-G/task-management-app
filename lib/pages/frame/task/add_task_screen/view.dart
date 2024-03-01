import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

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
              product.weight = double.parse(controller.weightController.text);
              product.status = controller.status.value;
              product.startDate = controller.startDate?.value;
              product.endDate = controller.endDate?.value;
              debugPrint('product toJson: ${product.toJson()}');
              controller.addProductTask(product);
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
                    hintText: 'Enter Your Username',
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 15.0),
                RoundedContainer(
                  height: 60.0,
                  radius: 5.0,
                  borderColor: Colors.grey,
                  containerColor: AppColor.scaffoldBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          padding: EdgeInsets.zero,
                          dropdownColor: Colors.white,
                          isDense: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                            size: 15.0,
                          ),
                          items: controller.state.categoryList.map((val) {
                            return DropdownMenuItem<String>(
                              value: val['value'],
                              child: Text(val['value']!),
                            );
                          }).toList(),
                          hint: Row(
                            children: <Widget>[
                              Obx(
                                () => Icon(
                                  Icons.label,
                                  color: (controller.category.value ==
                                          "quantitative")
                                      ? Colors.red
                                      : Colors.blue,
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Obx(
                                () => Text(
                                  controller.category.value,
                                  style: CustomTextStyle.textRegular.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onChanged: (String? val) {
                            controller.category.value = val!;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  width: 700,
                  child: CustomTextField(
                    controller: controller.weightController,
                    hintText: 'Enter Weight',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 15.0),
                RoundedContainer(
                  height: 60.0,
                  radius: 5.0,
                  borderColor: Colors.grey,
                  containerColor: AppColor.scaffoldBackground,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          padding: EdgeInsets.zero,
                          dropdownColor: Colors.white,
                          isDense: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                            size: 15.0,
                          ),
                          // items: AddProductTaskPage.statusList.map((val) {
                          items: controller.state.statusList.map((val) {
                            return DropdownMenuItem<String>(
                              value: val['value'],
                              child: Text(val['value']!),
                            );
                          }).toList(),
                          hint: Row(
                            children: <Widget>[
                              Obx(
                                () => Icon(
                                  Icons.circle,
                                  color: (controller.status.value == "to do")
                                      ? Colors.red
                                      : (controller.status.value ==
                                              'in progress')
                                          ? Colors.yellow
                                          : Colors.green,
                                ),
                              ),
                              const SizedBox(width: 15.0),
                              Obx(
                                () => Text(
                                  controller.status.value,
                                  style: CustomTextStyle.textRegular.copyWith(
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            ],
                          ),
                          onChanged: (String? val) {
                            controller.status.value = val!;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Start Date: '),
                        Obx(() => Text(
                            "${controller.startDate!.value.toTime()} - ${controller.startDate!.value.toDate()}"))
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () => controller.dateTimePickerWidget(
                          context, "start date"),
                    )
                  ],
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('End Date: '),
                        Obx(() => Text(
                            "${controller.endDate!.value.toTime()} - ${controller.endDate!.value.toDate()}"))
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () =>
                          controller.dateTimePickerWidget(context, "end date"),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
