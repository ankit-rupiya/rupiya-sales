import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:sales/constants/button_type_enums.dart';
import 'package:sales/core/elevated_buttons.dart';
import 'package:sales/core/text_felids.dart';
import 'package:sales/utils/validations.dart';

import '../controllers/update_customer_controller.dart';

class UpdateCustomerView extends GetView<UpdateCustomerController> {
  const UpdateCustomerView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Customer'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: controller.formKey,
            child: Column(
              children: [
                RSTextField(
                    label: 'Address',
                    initialData: controller.data.cFarmAddress,
                    onChange: (value) => controller.data =
                        controller.data.copyWith(cFarmAddress: value),
                    validation: (value) =>
                        cannotBeEmpty(value: value, name: 'Address')),
                RSTextField(
                    label: 'Crop Name',
                    initialData: controller.data.cropName,
                    onChange: (value) => controller.data =
                        controller.data.copyWith(cropName: value),
                    validation: (value) =>
                        cannotBeEmpty(value: value, name: 'Crop Name')),
                RSTextField(
                    label: 'Land area *',
                    hint: 'in Acers',
                    initialData: controller.data.landArea,
                    onChange: (value) => controller.data =
                        controller.data.copyWith(landArea: value),
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      TextInputFormatter.withFunction((oldValue, newValue) =>
                          RegExp(r"^[0-9]*[.]?[0-9]*$").hasMatch(newValue.text)
                              ? newValue
                              : oldValue)
                    ],
                    validation: (value) =>
                        cannotBeEmpty(value: value, name: 'Land area')),
                Obx(
                  () => GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      controller.interested.value =
                          !controller.interested.value;
                      controller.data = controller.data.copyWith(
                          interested: controller.interested.value ? 1 : 0);
                    },
                    child: AbsorbPointer(
                      child: RadioListTile(
                          value: true,
                          groupValue: controller.interested.value,
                          title: const Text(
                              'Is farmer interested in Organic Farming?'),
                          onChanged: (_) {}),
                    ),
                  ),
                ),
                RSElevatedButton(
                  title: 'Submit',
                  action: () {
                    if (controller.formKey.currentState?.validate() ?? false) {
                      controller.updateCustomer();
                    }
                  },
                  type: RSButtonType.primary,
                  height: kToolbarHeight,
                  width: Get.width,
                )
              ]
                  .map<Widget>((child) => Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: child is Obx ? 0 : 10),
                        child: child,
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
