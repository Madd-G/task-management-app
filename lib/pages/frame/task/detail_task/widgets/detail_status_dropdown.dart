import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
import '../index.dart';

class DetailStatusDropdown extends GetView<DetailTaskController> {
  const DetailStatusDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      radius: 5.0,
      borderColor: Colors.grey,
      containerColor: AppColor.scaffoldBackground,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: SizedBox(
          height: 20.0,
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              padding: EdgeInsets.zero,
              dropdownColor: Colors.white,
              menuMaxHeight: 150.0,
              isDense: true,
              icon: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
                size: 15.0,
              ),
              items: controller.state.statusList.map((val) {
                return DropdownMenuItem<String>(
                  value: val['value']!,
                  child: Text(val['value']!),
                );
              }).toList(),
              hint: Obx(
                () => Text(
                  controller.status.value.toString(),
                  style: CustomTextStyle.textRegular.copyWith(
                    color: Colors.grey,
                  ),
                ),
              ),
              onChanged: (String? val) {
                controller.status.value = val!;
                Task task = Task();
                task.id = controller.state.task.id;
                task.status = val;
                TaskAPI.updateTaskStatus(params: task);
              },
            ),
          ),
        ),
      ),
    );
  }
}
