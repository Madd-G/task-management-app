import 'package:flutter/material.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';

import 'detail_body.dart';

class TaskCreateUpdate extends StatelessWidget {
  const TaskCreateUpdate({super.key, required this.widget});

  final DetailBody widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
            "Created at: ${widget.data.createdAt!.toTime()} - ${widget.data.createdAt?.toDate()}"),
        const SizedBox(height: 10.0),
        Text(
            "Last update at: ${widget.data.updatedAt!.toTime()} - ${widget.data.updatedAt?.toDate()}")
      ],
    );
  }
}
