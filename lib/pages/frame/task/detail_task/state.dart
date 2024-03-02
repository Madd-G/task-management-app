import 'package:flutter/material.dart';
import 'package:konek_mobile/common/entities/entities.dart';

class DetailTaskState {
  DetailTaskState();

  Task task = Task();

  List<DropdownMenuItem<String>> menuItems = [
    const DropdownMenuItem(value: "USA", child: Text("USA")),
    const DropdownMenuItem(value: "Canada", child: Text("Canada")),
    const DropdownMenuItem(value: "Brazil", child: Text("Brazil")),
    const DropdownMenuItem(value: "England", child: Text("England")),
    const DropdownMenuItem(value: "England", child: Text("England")),
    const DropdownMenuItem(value: "England", child: Text("England")),
    const DropdownMenuItem(value: "England", child: Text("England")),
    const DropdownMenuItem(value: "England", child: Text("England")),
    const DropdownMenuItem(value: "England", child: Text("England")),
  ];

  final List<Map<String, String>> progressList = [
    {
      "label": "0",
      "value": "0",
    },
    {
      "label": "5",
      "value": "5",
    },
    {
      "label": "10",
      "value": "10",
    },
    {
      "label": "15",
      "value": "15",
    },
    {
      "label": "20",
      "value": "20",
    },
    {
      "label": "25",
      "value": "25",
    },
    {
      "label": "30",
      "value": "30",
    },
    {
      "label": "35",
      "value": "35",
    },
    {
      "label": "40",
      "value": "40",
    },
    {
      "label": "45",
      "value": "45",
    },
    {
      "label": "50",
      "value": "50",
    },
    {
      "label": "55",
      "value": "55",
    },
    {
      "label": "60",
      "value": "60",
    },
    {
      "label": "65",
      "value": "65",
    },
    {
      "label": "70",
      "value": "70",
    },
    {
      "label": "75",
      "value": "75",
    },
    {
      "label": "80",
      "value": "80",
    },
    {
      "label": "85",
      "value": "85",
    },
    {
      "label": "90",
      "value": "90",
    },
    {
      "label": "95",
      "value": "95",
    },
    {
      "label": "100",
      "value": "100",
    },
  ];
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
}
