import 'package:flutter/material.dart';
import 'package:konek_mobile/common/utils/utils.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    this.controller,
    this.filled = false,
    this.obscureText = false,
    this.readOnly = false,
    super.key,
    this.validator,
    this.fillColour,
    this.suffixIcon,
    this.hintText,
    this.keyboardType,
    this.hintStyle,
    this.overrideValidator = false,
    this.inputBorder,
    this.maxLines = 1,
  });

  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool filled;
  final int? maxLines;
  final Color? fillColour;
  final bool obscureText;
  final bool readOnly;
  final Widget? suffixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool overrideValidator;
  final TextStyle? hintStyle;
  final InputBorder? inputBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: overrideValidator
          ? validator
          : (value) {
              if (value == null || value.isEmpty || value == '') {
                return 'This field is required';
              }
              return validator?.call(value);
            },
      onTapOutside: (_) {
        FocusScope.of(context).unfocus();
      },
      maxLines: maxLines,
      keyboardType: keyboardType,
      obscureText: obscureText,
      readOnly: readOnly,
      decoration: InputDecoration(
          constraints: const BoxConstraints(maxWidth: 450.0),
          border: inputBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
          enabledBorder: inputBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: const BorderSide(color: Colors.grey),
              ),
          focusedBorder: inputBorder ??
              OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Theme.of(context).primaryColor,
                ),
              ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          filled: filled,
          fillColor: fillColour,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: hintStyle ?? CustomTextStyle.textRegular),
    );
  }
}
