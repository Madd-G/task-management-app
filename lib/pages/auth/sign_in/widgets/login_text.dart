import 'package:flutter/material.dart';

class LoginText extends StatelessWidget {
  const LoginText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 0.0, bottom: 30.0),
          child: const Text(
            "Login .",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              fontSize: 28.0,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(top: 0.0, bottom: 30.0),
          child: const Text(
            "Sign in with yout id and password",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 16.0,
            ),
          ),
        )
      ],
    );
  }
}
