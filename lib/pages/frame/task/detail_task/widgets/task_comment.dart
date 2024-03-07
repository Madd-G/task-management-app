import 'package:flutter/material.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';

import 'detail_body.dart';

class TaskComment extends StatelessWidget {
  const TaskComment({super.key, required this.widget});

  final DetailBody widget;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
                        (message.sender == UserStore.to.profile.username)
                            ? 'You'
                            : message.sender!,
                        style: CustomTextStyle.textSmallSemiBold,
                      ),
                      Text(
                          '${message.time!.toTime()} ${(DateTime.now().toDateWithoutYear() == message.time!.toDateWithoutYear()) ? '' : '- ${message.time!.toDateWithoutYear()}'}',
                          style: CustomTextStyle.textSmallSemiBold),
                    ],
                  ),
                  (message.commentType == 'text')
                      ? SizedBox(
                          width: size.width * 0.71,
                          child: Text(message.message!,
                              textAlign: TextAlign.justify))
                      : netImageCached(message.message!,
                          radius: 0.0, height: 200.0, width: 200.0),
                  const SizedBox(height: 15.0),
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
