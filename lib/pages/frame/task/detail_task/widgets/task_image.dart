import 'package:flutter/material.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';

import 'detail_body.dart';

class TaskImage extends StatelessWidget {
  const TaskImage({
    super.key,
    required this.widget,
  });

  final DetailBody widget;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return netImageCached(
                widget.data.imageUrl!,
                radius: 0,
                height: size.width,
                width: size.width,
                fit: BoxFit.cover,
              );
            },
          );
        },
        child: netImageCached(widget.data.imageUrl!,
            radius: 0.0, height: 200.0, width: 200.0));
  }
}
