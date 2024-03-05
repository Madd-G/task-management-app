import 'package:get/get.dart';

class AddTaskState {
  AddTaskState();

  final List<Map<String, String>> statusList = [
    {
      "label": "To Do",
      "value": "To Do",
    },
    {
      "label": "In Progress",
      "value": "In Progress",
    },
    {
      "label": "Done",
      "value": "Done",
    },
  ];
  final List<Map<String, String>> priorityList = [
    {
      "label": "Low",
      "value": "Low",
    },
    {
      "label": "Medium",
      "value": "Medium",
    },
    {
      "label": "High",
      "value": "High",
    },
  ];

  final List<Map<String, String>> categoryList = [
    {
      "label": "Quantitative",
      "value": "Quantitative",
    },
    {
      "label": "Qualitative",
      "value": "Qualitative",
    },
  ];

  RxList employeeList = [].obs;
}
