import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';
import 'package:konek_mobile/common/routes/routes.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/progress_widget.dart';
import 'package:konek_mobile/common/widgets/rounded_container.dart';

class TaskCard extends StatelessWidget {
  final Task task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(AppRoutes.DETAIL_TASK, arguments: task);
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      task.name!,
                      style: CustomTextStyle.textExtraLargeSemiBold,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 15.0),
                  RoundedContainer(
                    radius: 12.0,
                    containerColor: (task.priority! == "Low")
                        ? Colors.green
                        : (task.priority! == "Medium")
                            ? Colors.yellow
                            : AppColor.redColor,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 4.0, horizontal: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.local_fire_department_outlined,
                            size: 20.0,
                          ),
                          const SizedBox(width: 2.0),
                          Text(
                            task.priority!,
                            style: CustomTextStyle.textRegularSemiBold,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  if (UserStore.to.profile.role == 'owner')
                    Row(
                      children: [
                        const Icon(Icons.person_2_outlined, size: 20.0),
                        const SizedBox(width: 5.0),
                        Text(
                          task.assignee!,
                          style: const TextStyle(fontSize: 16),
                        ),
                        const SizedBox(width: 10.0),
                      ],
                    ),
                  Row(
                    children: [
                      RoundedContainer(
                        radius: 5.0,
                        containerColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6.0, horizontal: 8.0),
                          child: Text(
                            task.target!,
                            style: CustomTextStyle.textRegularSemiBold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      RoundedContainer(
                        radius: 5.0,
                        containerColor: Colors.black,
                        borderColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 12.0),
                          child: Text(
                            task.status!,
                            style: CustomTextStyle.textSmallSemiBold
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.watch_later_outlined),
                      const SizedBox(width: 6.0),
                      Text(
                        task.endDate!.toDate(),
                        style: CustomTextStyle.textRegularSemiBold,
                      ),
                    ],
                  ),
                  ProgressWidget(progress: task.progress!.toInt()),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
