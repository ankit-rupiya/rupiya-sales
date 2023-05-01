import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/modules/add_customer_form/controllers/add_customer_form_controller.dart';
import 'package:sales/constants/button_type_enums.dart';
import 'package:sales/core/dialog.dart';
import 'package:sales/core/elevated_buttons.dart';

class ConfirmDialog extends GetView<AddCustomerFormController> {
  const ConfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return RSDialog(
      title: 'Confirm submission',
      body: ListView(
        shrinkWrap: true,
        children: [
          Text('First Name: ${controller.formDataParams.customerFirstName}'),
          Text('Middle Name: ${controller.formDataParams.customerMiddleName}'),
          Text('Last Name: ${controller.formDataParams.customerLastName}'),
          Text('Contact no.: ${controller.formDataParams.mobileNo}'),
          Text('Address: ${controller.formDataParams.address}'),
          Text('Crop(s): ${controller.formDataParams.cropName}'),
          Text('Land Area: ${controller.formDataParams.landArea}'),
          Text(
              'Organic Farming: ${controller.interested.value ? 'Interested' : 'Not Interested'}'),
        ],
      ),
      actions: [
        RSElevatedButton(
          title: 'Edit',
          action: Get.back,
          type: RSButtonType.plainOnBlack,
          height: kToolbarHeight,
          width: Get.width,
        ),
        RSElevatedButton(
          title: 'Submit',
          action: () {
            Get.back();
            controller.addCustomerDetails();
          },
          type: RSButtonType.primary,
          height: kToolbarHeight,
          width: Get.width,
        )
      ],
    );
  }
}
