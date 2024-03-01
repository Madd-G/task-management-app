class AddProductTaskState {
  AddProductTaskState();


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
}
