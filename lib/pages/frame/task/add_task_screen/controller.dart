import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'index.dart';

class AddTaskController extends GetxController {
  final AddTaskState state = AddTaskState();
  final nameController = TextEditingController();
  final weightController = TextEditingController();
  final addCompanyFormKey = GlobalKey<FormState>();
  RxString status = 'To Do'.obs;
  RxString category = 'Quantitative'.obs;
  Rx<DateTime>? startDate = DateTime.now().obs;
  Rx<DateTime>? endDate = DateTime.now().obs;

  @override
  void onClose() {
    nameController.dispose();
    weightController.dispose();
    super.onClose();
  }

  void addProductTask(Task product) {
    ProductAPI.addProductTask(params: product);
    Get.back();
  }

  void dateTimePickerWidget(BuildContext context, String date) {
    DatePicker.showDatePicker(
      context,
      dateFormat: 'dd MMMM yyyy HH:mm',
      initialDateTime: DateTime.now(),
      minDateTime: DateTime(DateTime.now().year),
      maxDateTime: DateTime(2050),
      onMonthChangeStartWithFirstDate: true,
      onConfirm: (dateTime, List<int> index) {
        if (date == "start date") {
          startDate?.value = dateTime;
          print('startDate?.value: ${startDate?.value}');
        } else if (date == "end date") {
          endDate?.value = dateTime;
          print('endDate?.value: ${endDate?.value}');

        }
        update();
      },
    );
  }
}
