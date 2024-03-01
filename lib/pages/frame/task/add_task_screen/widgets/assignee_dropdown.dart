import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
import 'package:konek_mobile/pages/frame/task/add_task_screen/index.dart';

class AssigneeDropdown extends GetView<AddTaskController> {
  const AssigneeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => RoundedContainer(
        height: 60.0,
        radius: 5.0,
        borderColor: Colors.grey,
        containerColor: AppColor.scaffoldBackground,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<UserEntity>(
                padding: EdgeInsets.zero,
                dropdownColor: Colors.white,
                isDense: true,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.grey,
                  size: 15.0,
                ),
                items: controller.state.employeeList.map((val) {
                  return DropdownMenuItem<UserEntity>(
                    value: val,
                    child: Text("${val.username} - ${val.role}"),
                  );
                }).toList(),
                hint: Obx(
                  () => Text(
                    controller.employeeName.value,
                    style: CustomTextStyle.textRegular.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ),
                onChanged: (UserEntity? val) {
                  controller.employeeName.value = val!.username!;
                  controller.employeeRole.value = val.role!;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
