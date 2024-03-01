import 'package:flutter/material.dart';
import 'package:flutter_cupertino_datetime_picker/flutter_cupertino_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/apis/apis.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';
import 'package:konek_mobile/common/widgets/app_dropdown.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';
import 'package:uuid/uuid.dart';

class AddProductTaskPage extends StatefulWidget {
  const AddProductTaskPage({super.key});

  static final List<Map<String, String>> statusList = [
    {
      "label": "To Do",
      "value": "to do",
    },
    {
      "label": "In Progress",
      "value": "in progress",
    },
    {
      "label": "Done",
      "value": "done",
    },
  ];

  static final List<Map<String, String>> categoryList = [
    {
      "label": "Quantitative",
      "value": "quantitative",
    },
    {
      "label": "Qualitative",
      "value": "qualitative",
    },
  ];

  @override
  State<AddProductTaskPage> createState() => _AddProductTaskState();
}

class _AddProductTaskState extends State<AddProductTaskPage> {
  final nameController = TextEditingController();
  final categoryController = TextEditingController();
  final weightController = TextEditingController();
  final addCompanyFormKey = GlobalKey<FormState>();
  RxString? status = 'To Do'.obs;
  DateTime? startDate;
  DateTime? endDate;

  @override
  void dispose() {
    nameController.dispose();
    categoryController.dispose();
    weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Uuid uuid = Uuid();
    dateTimePickerWidget(BuildContext context, String date) {
      DatePicker.showDatePicker(
        context,
        dateFormat: 'dd MMMM yyyy HH:mm',
        initialDateTime: DateTime.now(),
        minDateTime: DateTime(DateTime.now().year),
        maxDateTime: DateTime(2050),
        onMonthChangeStartWithFirstDate: true,
        onConfirm: (dateTime, List<int> index) {
          setState(() {
            if (date == "start date") {
              startDate = dateTime;
            } else if (date == "end date") {
              endDate = dateTime;
            }
          });
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Product Task'),
        actions: [
          TextButton(
              onPressed: () {
                Product product = Product();
                product.id = uuid.v8();
                product.name = nameController.text;
                product.category = categoryController.text;
                product.weight = double.parse(weightController.text);
                product.status = status?.value;
                product.startDate = startDate;
                product.endDate = endDate;
                debugPrint('product toJson: ${product.toJson()}');
                ProductAPI.addProductTask(params: product);
                Get.back();
              },
              child: const Text('SAVE'))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: addCompanyFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10.0),
                SizedBox(
                  width: 700,
                  child: CustomTextField(
                    controller: nameController,
                    hintText: 'Enter Your Username',
                    keyboardType: TextInputType.name,
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  width: 700,
                  child: CustomTextField(
                    controller: categoryController,
                    hintText: 'Enter Category',
                    keyboardType: TextInputType.text,
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                  width: 700,
                  child: CustomTextField(
                    controller: weightController,
                    hintText: 'Enter Weight',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(height: 15.0),
                StatusDropdown(status: status),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text('Start Date: '),
                        Text(startDate == null
                            ? '-'
                            : startDate!.toCustomFormat())
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () =>
                          dateTimePickerWidget(context, "start date"),
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
                        Text(endDate == null ? '-' : endDate!.toCustomFormat())
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.calendar_month),
                      onPressed: () =>
                          dateTimePickerWidget(context, "end date"),
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
