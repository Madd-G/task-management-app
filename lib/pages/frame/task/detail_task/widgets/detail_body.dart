import 'package:flutter/material.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/extensions/extensions.dart';
import 'package:konek_mobile/common/store/store.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/pages/frame/task/detail_task/widgets/widgets.dart';

class DetailBody extends StatelessWidget {
  const DetailBody({super.key, required this.data});

  final Task data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DataCarousel(data: data),
              const SizedBox(height: 10.0),
              const Text(
                'Description',
                style: CustomTextStyle.text3ExtraLargeSemiBold,
              ),
              Text(
                data.description!,
                style: CustomTextStyle.textLargeRegular,
              ),
              const SizedBox(height: 10.0),
              const Row(
                children: [
                  Text('progress: '),
                  DetailProgressDropdown(),
                ],
              ),
              const SizedBox(height: 10.0),
              const Row(
                children: [
                  Text('status     : '),
                  DetailStatusDropdown(),
                ],
              ),
              const SizedBox(height: 10.0),
              if (UserStore.to.profile.role == "owner")
                const Row(
                  children: [
                    Text('priority     : '),
                    DetailPriorityDropdown(),
                  ],
                ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "Created at: ${data.createdAt!.toTime()} - ${data.createdAt?.toDate()}"),
              const SizedBox(height: 10.0),
              Text(
                  "Last update at: ${data.updatedAt!.toTime()} - ${data.updatedAt?.toDate()}")
            ],
          ),
        ],
      ),
    );
  }
}
