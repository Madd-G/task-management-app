import 'package:flutter/material.dart';
import 'package:konek_mobile/common/style/style.dart';

Widget inputTextEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  TextAlign? textAlign = TextAlign.start,
  bool isPassword = false,
  bool readOnly = false,
  double marginTop = 15,
  double height = 44,
  bool autofocus = false,
  Widget? clearWidget,
  VoidCallback? onPressed,
  ValueChanged<String>? onchanged,
}) {
  return Container(
    height: height,
    margin: EdgeInsets.only(top: marginTop),
    decoration: const BoxDecoration(
      color: AppColor.secondaryColor,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: TextField(
      scrollPadding: EdgeInsets.zero,
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        suffixIcon: clearWidget,
        hintStyle: const TextStyle(color: AppColor.secondaryText),
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        isDense: true,
        border: InputBorder.none,
      ),
      style: const TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
      ),
      maxLines: 1,
      textAlign: textAlign ?? TextAlign.start,
      autocorrect: false,
      readOnly: readOnly,
      //
      obscureText: isPassword,
      onTap: onPressed,
      onChanged: onchanged,
    ),
  );
}

Widget inputTextAreaEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  bool isPassword = false,
  double marginTop = 15,
  bool autofocus = false,
  ValueChanged<String>? onchanged,
}) {
  return Container(
    height: 100.0,
    margin: EdgeInsets.only(top: marginTop),
    decoration: const BoxDecoration(
      color: AppColor.secondaryColor,
      borderRadius: BorderRadius.all(Radius.circular(20)),
    ),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColor.secondaryText),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        border: InputBorder.none,
      ),
      style: const TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 16.0,
      ),
      maxLines: 3,
      autocorrect: false,
      obscureText: isPassword,
      onChanged: onchanged,
    ),
  );
}

Widget inputEmailEdit({
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  String? hintText,
  bool isPassword = false,
  double marginTop = 15,
  bool autofocus = false,
}) {
  return Container(
    height: 44.0,
    margin: EdgeInsets.only(top: marginTop),
    decoration: const BoxDecoration(
      color: AppColor.scaffoldBackground,
      borderRadius: BorderRadius.all(Radius.circular(20)),
      boxShadow: [
        BoxShadow(
          color: Color.fromARGB(41, 0, 0, 0),
          offset: Offset(0, 1),
          blurRadius: 0,
        ),
      ],
    ),
    child: TextField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 0, 9),
        border: InputBorder.none,
        hintStyle: const TextStyle(
          color: AppColor.primaryText,
        ),
      ),
      style: const TextStyle(
        color: AppColor.primaryText,
        fontWeight: FontWeight.w400,
        fontSize: 18.0,
      ),
      maxLines: 1,
      autocorrect: false,
      obscureText: isPassword,
    ),
  );
}
