import 'package:flutter/material.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';
import 'package:konek_mobile/common/widgets/widgets.dart';

class DataCarousel extends StatelessWidget {
  const DataCarousel({super.key, required this.data});

  final Task data;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 10.0,
      children: [
        RoundedContainer(
          radius: 5.0,
          containerColor: Colors.white,
          borderColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            child: Text(
              data.target!,
              style: CustomTextStyle.textSmallSemiBold,
            ),
          ),
        ),
        RoundedContainer(
          radius: 5.0,
          containerColor: (data.priority! == "Low")
              ? Colors.green
              : (data.priority! == "Medium")
              ? Colors.yellow
              : AppColor.redColor,
          borderColor: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
            child: Text(
              data.priority!,
              style: CustomTextStyle.textSmallSemiBold,
            ),
          ),
        ),
        RoundedContainer(
          radius: 5.0,
          containerColor: (data.category! == 'qualitative')
              ? Colors.indigoAccent
              : Colors.blue,
          borderColor: Colors.black,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            child: Text(
              data.category!,
              style: CustomTextStyle.textSmallSemiBold,
            ),
          ),
        ),
        RoundedContainer(
          radius: 5.0,
          containerColor: Colors.black,
          borderColor: Colors.black,
          child: Padding(
            padding:
            const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
            child: Text(
              data.status!,
              style: CustomTextStyle.textSmallSemiBold
                  .copyWith(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
