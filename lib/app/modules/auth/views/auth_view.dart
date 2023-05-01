import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales/constants/button_type_enums.dart';
import 'package:sales/core/dialog.dart';
import 'package:sales/core/elevated_buttons.dart';
import 'package:sales/core/text_felids.dart';
import 'package:sales/utils/validations.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Form(
            key: controller.loginFormKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: kToolbarHeight * 3,
                  ),
                  const Text(
                    'Welcome to Rupiya Sales app',
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: kToolbarHeight,
                  ),
                  RSTextField(
                      label: 'Username',
                      onChange: (value) => controller.username = value,
                      validation: (value) =>
                          cannotBeEmpty(value: value, name: 'Username')),
                  const SizedBox(
                    height: 20,
                  ),
                  RSTextField(
                    label: 'Password',
                    onChange: (value) => controller.password = value,
                    isPassword: true,
                    textInputAction: TextInputAction.go,
                    validation: (value) =>
                        cannotBeEmpty(value: value, name: 'Password'),
                    onFieldSubmitted: (_) => controller.login(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      children: [
                        const Spacer(),
                        TextButton(
                            onPressed: () {
                              Get.dialog(RSDialog(
                                  message:
                                      'Contact your Administrator to rest your password',
                                  actions: [
                                    RSElevatedButton(
                                        title: 'Ok', action: Get.back),
                                  ]));
                            },
                            child: const Text('forgot password'))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  RSElevatedButton(
                    title: 'Login',
                    action: () => controller.login(),
                    type: RSButtonType.primary,
                    height: kToolbarHeight,
                    width: Get.width,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  // Row(
                  //   children: [
                  //     const Text('Don\'t have an account?'),
                  //     TextButton(
                  //         onPressed: () => Get.offAndToNamed(Routes.REGISTER),
                  //         child: const Text('Register'))
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
