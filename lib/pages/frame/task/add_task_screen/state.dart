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
}
