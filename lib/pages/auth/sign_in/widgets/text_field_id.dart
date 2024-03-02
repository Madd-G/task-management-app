import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/pages/auth/sign_in/controller.dart';

class TextFieldId extends GetView<SignInController> {
  const TextFieldId({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 295.0,
        height: 44.0,
        margin: const EdgeInsets.only(bottom: 20.0, top: 0.0),
        padding: const EdgeInsets.all(0.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
            ),
          ],
        ),
        child: TextField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "Enter your id",
            contentPadding: EdgeInsets.fromLTRB(15, 0, 15, 0),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 14.0,
          ),
          onChanged: (value) {
            controller.state.id.value = value;
          },
          maxLines: 1,
          autocorrect: false,
          obscureText: false,
        ));
  }
}
