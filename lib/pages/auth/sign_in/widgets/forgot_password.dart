import 'package:flutter/material.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260.0,
      height: 44.0,
      child: GestureDetector(
          child: const Text(
            "Forgot password?",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.black,
              decoration: TextDecoration.underline,
              decorationColor: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 12.0,
            ),
          ),
          onTap: () {
            // Get.toNamed(AppRoutes.Forgot);
          }),
    );
  }
}
