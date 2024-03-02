import 'package:flutter/material.dart';

class RegisterText extends StatelessWidget {
  const RegisterText({
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Don't have an account?",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 12.0,
          ),
        ),
        GestureDetector(
            child: const Text(
              "Register here",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.normal,
                decoration: TextDecoration.underline,
                decorationColor: Colors.blue,
                fontSize: 12.0,
              ),
            ),
            onTap: () {
              // Get.toNamed(AppRoutes.Register);
            }),
      ],
    );
  }
}
