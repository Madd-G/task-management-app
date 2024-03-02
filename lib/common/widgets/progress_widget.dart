import 'package:flutter/material.dart';
import 'package:konek_mobile/common/style/style.dart';
import 'package:konek_mobile/common/utils/utils.dart';

class ProgressWidget extends StatelessWidget {
  const ProgressWidget({super.key, required this.progress});

  final int progress;

  @override
  Widget build(BuildContext context) {
    const double size = 40.0;
    return Stack(
      children: [
        Container(
          height: size,
          width: size,
          decoration: const BoxDecoration(
            color: AppColor.accentColor,
            borderRadius: BorderRadius.all(Radius.circular(18.51)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 5),
                color: Color(0xFFC5D1C6),
                blurRadius: 2.0,
                spreadRadius: 1.5,
              )
            ],
          ),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  progress.toString(),
                  style: CustomTextStyle.textExtraSmallMedium.copyWith(
                      fontSize: 12.0,
                      color: AppColor.baseWhite,
                      fontFamily: 'Rubik'),
                ),
                Text(
                  '%',
                  style: CustomTextStyle.textExtraSmallMedium.copyWith(
                      fontSize: 5.0,
                      color: AppColor.baseWhite,
                      fontFamily: 'Rubik'),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 3.0,
            color: AppColor.baseWhite,
            value: 1,
          ),
        ),
        SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            color: AppColor.redColor,
            value: progress / 100,
          ),
        ),
      ],
    );
  }
}
