import 'package:flutter/material.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/pages/frame/task/detail_task/widgets/widgets.dart';

class DetailTask extends StatelessWidget {
  const DetailTask({
    super.key,
    required this.data,
    required this.context,
  });

  final Task data;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          DetailHeader(data: data),
          DetailBody(data: data),
        ],
      ),
    );
  }
}
