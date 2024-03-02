import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:konek_mobile/pages/auth/sign_in/widgets/widgets.dart';
import 'index.dart';

class SignInScreen extends GetView<SignInController> {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: const EdgeInsets.symmetric(
            vertical: 15.0,
            horizontal: 15.0,
          ),
          sliver: SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.only(bottom: 0.0, top: 0.0),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 100.0),
                  LoginText(),
                  TextFieldId(),
                  TextFieldPassword(),
                  ForgotPassword(),
                  SignInButton(),
                  RegisterText()
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

