import 'package:flutter/material.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';

import 'detail_body.dart';

class TaskComment extends StatelessWidget {
  const TaskComment({
    super.key,
    required this.widget,
  });

  final DetailBody widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RoundedContainer(
          boxConstraints: const BoxConstraints(maxHeight: 400.0),
          radius: 10.0,
          borderColor: Colors.black,
          containerColor: AppColor.borderColor,
          child: ListView.builder(
            shrinkWrap: true,
            padding: const EdgeInsets.all(8.0),
            scrollDirection: Axis.vertical,
            itemCount: widget.data.messages!.length,
            itemBuilder: (context, index) {
              var message = widget.data.messages![index];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        (message.sender == UserStore.to.profile.id)
                            ? 'You'
                            : message.sender!,
                        style: CustomTextStyle.textSmallSemiBold,
                      ),
                      Text(
                          '${message.time!.toTime()} - ${message.time!.toDateWithoutYear()}',
                          style: CustomTextStyle.textSmallSemiBold),
                    ],
                  ),
                  Text(message.message!),
                  const SizedBox(height: 5.0),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 20.0),
      ],
    );
  }
}

