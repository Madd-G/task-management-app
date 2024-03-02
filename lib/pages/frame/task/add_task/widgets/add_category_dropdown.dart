import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
import '../index.dart';

class AddCategoryDropdown extends GetView<AddTaskController> {
  const AddCategoryDropdown({super.key});

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
              hint: Obx(
                () => Row(
                  children: <Widget>[
                    Icon(
                      Icons.label,
                      color: (controller.category.value == "quantitative")
                          ? Colors.indigoAccent
                          : Colors.blue,
                    ),
                    const SizedBox(width: 15.0),
                    Text(
                      controller.category.value,
                      style: CustomTextStyle.textRegular.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
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
