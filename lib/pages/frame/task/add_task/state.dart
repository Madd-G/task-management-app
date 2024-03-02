import 'package:get/get.dart';

class AddTaskState {
  AddTaskState();

  final List<Map<String, String>> statusList = [
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
  ];  final List<Map<String, String>> priorityList = [
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
      "value": "quantitative",
    },
    {
      "label": "Qualitative",
      "value": "qualitative",
    },
  ];

  RxList employeeList = [].obs;

// final List<Map<String, String>> employeeList = [
//   {
//     "label": "Lina",
//     "value": "Lina",
//   },
//   {
//     "label": "Lionel",
//     "value": "Lionel",
//   }, {
//     "label": "Rachel",
//     "value": "Rachel",
//   },
// ];
}
