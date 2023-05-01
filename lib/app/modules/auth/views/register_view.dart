import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:sales/app/modules/auth/controllers/auth_controller.dart';
import 'package:sales/app/routes/app_pages.dart';
import 'package:sales/constants/button_type_enums.dart';
import 'package:sales/constants/enums.dart';
import 'package:sales/core/elevated_buttons.dart';
import 'package:sales/core/text_felids.dart';
import 'package:sales/utils/validations.dart';

class RegisterView extends GetView<AuthController> {
  const RegisterView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container();
    // return Scaffold(
    //   body: SizedBox(
    //     height: MediaQuery.of(context).size.height,
    //     width: MediaQuery.of(context).size.width,
    //     child: SingleChildScrollView(
    //       child: Form(
    //         key: controller.registerFormKey,
    //         child: Padding(
    //           padding:
    //               const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               const SizedBox(
    //                 height: kToolbarHeight,
    //               ),
    //               const Text(
    //                 'Welcome to Rupiya Sales app',
    //                 style: TextStyle(fontSize: 20),
    //               ),
    //               const SizedBox(
    //                 height: kToolbarHeight,
    //               ),
    //               RSTextField(
    //                   label: 'Username',
    //                   onChange: (value) => controller.username = value,
    //                   validation: (value) =>
    //                       cannotBeEmpty(value: value, name: 'Username')),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               RSTextField(
    //                   label: 'Mobile no.',
    //                   onChange: (value) => controller.username = value,
    //                   validation: (value) =>
    //                       cannotBeEmpty(value: value, name: 'Mobile no.')),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               DropdownButtonFormField(
    //                   hint: const Text('Select Role'),
    //                   items: List.generate(
    //                       Role.values.length,
    //                       (index) => DropdownMenuItem<Role>(
    //                           value: Role.values[index],
    //                           child: Text(Role.values[index].viewName))),
    //                   onChanged: (value) {
    //                     controller.user.value =
    //                         controller.user.value!.copyWith(authorization: value,department: '');
    //                     controller.update([controller.rebuildSubCategory]);
    //                   }),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               GetBuilder<AuthController>(
    //                 id: controller.rebuildSubCategory,
    //                 builder: (__) {
    //                   if (controller.user.value.authorization != null) {
    //                     return DropdownButtonFormField(
    //                         key: UniqueKey(),
    //                         hint: const Text('Select department'),
    //                         items: List.generate(
    //                             controller.user.value!.authorization.roleField.length,
    //                             (index) => DropdownMenuItem<String>(
    //                                 value: controller.user.value!.authorization.roleField[index],
    //                                 child: Text(controller.user.value!.authorization.roleField[index]))),
    //                         onChanged: (value) =>
    //                             controller.department = value!);
    //                   } else {
    //                     return const SizedBox.shrink();
    //                   }
    //                 },
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               RSTextField(
    //                 label: 'Password',
    //                 onChange: (value) => controller.password = value,
    //                 isPassword: true,
    //                 textInputAction: TextInputAction.go,
    //                 validation: (value) =>
    //                     cannotBeEmpty(value: value, name: 'Password'),
    //                 onFieldSubmitted: (_) => controller.login(),
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               RSTextField(
    //                 label: 'Confirm password',
    //                 onChange: (value) => controller.password = value,
    //                 isPassword: true,
    //                 textInputAction: TextInputAction.go,
    //                 validation: (value) =>
    //                     cannotBeEmpty(value: value, name: 'Confirm password'),
    //                 onFieldSubmitted: (_) => controller.login(),
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               RSElevatedButton(
    //                 title: 'Register',
    //                 action: () => controller.login(),
    //                 type: RSButtonType.primary,
    //                 height: kToolbarHeight,
    //                 width: Get.width,
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //               Row(
    //                 children: [
    //                   const Text('Already have an account?'),
    //                   TextButton(
    //                       onPressed: () => Get.offAndToNamed(Routes.AUTH),
    //                       child: const Text('Login'))
    //                 ],
    //               ),
    //               const SizedBox(
    //                 height: 20,
    //               ),
    //             ],
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }
}
