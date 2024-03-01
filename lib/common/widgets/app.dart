import 'package:flutter/material.dart';
import 'package:konek_mobile/common/style/style.dart';

///  AppBar
AppBar transparentAppBar({
  Widget? title,
  Widget? leading,
  List<Widget>? actions,
}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 176, 106, 231),
          Color.fromARGB(255, 166, 112, 232),
          Color.fromARGB(255, 131, 123, 232),
          Color.fromARGB(255, 104, 132, 231),
        ], transform: GradientRotation(90)),
      ),
    ),
    title: title != null ? Center(child: title) : null,
    leading: leading,
    actions: actions,
  );
}

Widget divider10Px({Color bgColor = AppColor.secondaryText}) {
  return Container(
    height: 10.0,
    decoration: BoxDecoration(
      color: bgColor,
    ),
  );
}
