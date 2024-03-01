import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';
import 'package:konek_mobile/pages/frame/task/add_task_screen/index.dart';

class DateTimeRow extends GetView<AddTaskController> {
  final String title;
  final Rx<DateTime>? dateTime;
  final VoidCallback onPressed;

  const DateTimeRow({
    super.key,
    required this.title,
    required this.dateTime,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text('$title: '),
            Obx(() => Text(
                "${dateTime!.value.toTime()} - ${dateTime!.value.toDate()}"))
          ],
        ),
        IconButton(
          icon: const Icon(Icons.calendar_month),
          onPressed: onPressed,
        )
      ],
    );
  }
}
