import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
import 'package:konek_mobile/pages/frame/task/add_task_screen/index.dart';

class CategoryDropdown extends GetView<AddTaskController> {
  const CategoryDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
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
                      color: (controller.category.value == "quantitative")
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
    );
  }
}
