import 'package:flutter/material.dart';
import 'package:konek_mobile/common/entities/entities.dart';
import 'package:konek_mobile/common/style/style.dart';

class ProfileBadge extends StatelessWidget {
  const ProfileBadge({super.key, required this.data});

  final BusinessProfile data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: data.businessSector
          !.map((e) => Padding(
        padding:
        const EdgeInsets.only(top: 8.0, right: 12.0, bottom: 8.0),
        child: Container(
            padding: const EdgeInsets.symmetric(
                vertical: 8.0, horizontal: 6.0),
            decoration: const BoxDecoration(
              color: AppColor.yellowColor,
              borderRadius: BorderRadius.all(
                Radius.circular(4.0),
              ),
            ),
            child: Text(e)),
      ))
          .toList(),
    );
  }
}
