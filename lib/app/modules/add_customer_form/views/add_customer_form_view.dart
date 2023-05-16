import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sales/app/modules/add_customer_form/views/widgets/confirmation_dialog.dart';
import 'package:sales/constants/button_type_enums.dart';
import 'package:sales/core/elevated_buttons.dart';
import 'package:sales/core/text_felids.dart';
import 'package:sales/utils/validations.dart';

import '../controllers/add_customer_form_controller.dart';

class AddCustomerFormView extends GetView<AddCustomerFormController> {
  const AddCustomerFormView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Lead'),
        centerTitle: true,
      ),
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GetBuilder<AddCustomerFormController>(builder: (_) {
            return Form(
              key: controller.formKey,
              child: SingleChildScrollView(
                child: Column(
                  key: UniqueKey(),
                  children: [
                    RSTextField(
                      label: 'Name *',
                      initialData:
                          controller.formDataParams.customerFirstName.isNotEmpty
                              ? controller.formDataParams.customerFirstName
                              : null,
                      onChange: (value) => controller.formDataParams =
                          controller.formDataParams
                              .copyWith(customerFirstName: value),
                      validation: (value) =>
                          cannotBeEmpty(value: value, name: 'Name'),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) =>
                            RegExp(r"^[a-zA-Z]*$").hasMatch(newValue.text)
                                ? newValue
                                : oldValue)
                      ],
                    ),
                    RSTextField(
                      label: 'Father name',
                      initialData: controller
                              .formDataParams.customerMiddleName.isNotEmpty
                          ? controller.formDataParams.customerMiddleName
                          : null,
                      onChange: (value) => controller.formDataParams =
                          controller.formDataParams
                              .copyWith(customerMiddleName: value),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) =>
                            RegExp(r"^[a-zA-Z]*$").hasMatch(newValue.text)
                                ? newValue
                                : oldValue)
                      ],
                    ),
                    RSTextField(
                      label: 'Surname *',
                      initialData:
                          controller.formDataParams.customerLastName.isNotEmpty
                              ? controller.formDataParams.customerLastName
                              : null,
                      onChange: (value) => controller.formDataParams =
                          controller.formDataParams
                              .copyWith(customerLastName: value),
                      validation: (value) =>
                          cannotBeEmpty(value: value, name: 'Surname'),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) =>
                            RegExp(r"^[a-zA-Z]*$").hasMatch(newValue.text)
                                ? newValue
                                : oldValue)
                      ],
                    ),
                    RSTextField(
                      label: 'Mobile number *',
                      initialData: controller.formDataParams.mobileNo.isNotEmpty
                          ? controller.formDataParams.mobileNo
                          : null,
                      onChange: (value) => controller.formDataParams =
                          controller.formDataParams.copyWith(mobileNo: value),
                      keyboardType: TextInputType.phone,
                      validation: (value) => validatePhoneNumber(
                          value: value, name: 'Mobile number'),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                    Obx(
                      () => controller.showAddress.value
                          ? Column(
                              children: [
                                RSTextField(
                                    label: 'Address *',
                                    onChange: (value) =>
                                        controller.address = value,
                                    validation: (value) => cannotBeEmpty(
                                        value: value, name: 'Address')),
                                // RSTextField(
                                //     label: 'Village *',
                                //     onChange: (value) =>
                                //         controller.selectedVillage = value,
                                //     validation: (value) => cannotBeEmpty(
                                //         value: value, name: 'Village')),
                                DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                        label: Text('Village *'),
                                        border: OutlineInputBorder()),
                                    onChanged: (value) =>
                                        controller.selectedVillage = value!,
                                    validator: (value) => cannotBeEmpty(
                                        value: value, name: 'Village'),
                                    items: controller.possibilitiesMenuEntries),
                                // RSTextField(
                                //     label: 'Taluka *',
                                //     onChange: (value) =>
                                //         controller.selectedTaluka = value,
                                //     validation: (value) => cannotBeEmpty(
                                //         value: value, name: 'Taluka')),
                                DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                        label: Text('Taluka *'),
                                        border: OutlineInputBorder()),
                                    onChanged: (value) =>
                                        controller.selectedTaluka = value!,
                                    validator: (value) => cannotBeEmpty(
                                        value: value, name: 'Taluka'),
                                    items: controller.possibilitiesMenuEntries),
                                // RSTextField(
                                //     label: 'District *',
                                //     onChange: (value) =>
                                //         controller.selectedDistrict = value,
                                //     validation: (value) => cannotBeEmpty(
                                //         value: value, name: 'District')),
                                DropdownButtonFormField<String>(
                                    decoration: const InputDecoration(
                                        label: Text('District *'),
                                        border: OutlineInputBorder()),
                                    onChanged: (value) =>
                                        controller.selectedDistrict = value!,
                                    validator: (value) => cannotBeEmpty(
                                        value: value, name: 'District'),
                                    items: controller.possibilitiesMenuEntries),
                                RSTextField(
                                    label: 'State *',
                                    readOnly: true,
                                    initialData: controller.state,
                                    onChange: (value) =>
                                        controller.state = value,
                                    validation: (value) => cannotBeEmpty(
                                        value: value, name: 'State')),
                              ]
                                  .map<Widget>((child) => Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: child,
                                      ))
                                  .toList(),
                            )
                          : const SizedBox.shrink(),
                    ),
                    RSTextField(
                      label: 'PIN *',
                      onChange: (value) => controller.pin.value = value,
                      validation: validatePIN,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Expanded(
                    //       child: RSTextField(
                    //         label: 'PIN *',
                    //         onChange: (value) => controller.pin = value,
                    //         validation: (value) =>
                    //             cannotBeEmpty(value: value, name: 'PIN'),
                    //         inputFormatters: [
                    //           FilteringTextInputFormatter.digitsOnly
                    //         ],
                    //       ),
                    //     ),
                    //     const SizedBox.square(
                    //       dimension: 10,
                    //     ),
                    //     Flexible(
                    //       child: RSElevatedButton(
                    //         title: 'Fetch Address',
                    //         action: () => controller.showAddress.toggle(),
                    //         type: RSButtonType.primary,
                    //         height: kToolbarHeight,
                    //         width: Get.width,
                    //       ),
                    //     )
                    //   ],
                    // ),
                    RSTextField(
                      label: 'Crop name *',
                      initialData: controller.formDataParams.cropName.isNotEmpty
                          ? controller.formDataParams.cropName
                          : null,
                      onChange: (value) => controller.formDataParams =
                          controller.formDataParams.copyWith(cropName: value),
                      validation: (value) =>
                          cannotBeEmpty(value: value, name: 'Crop name'),
                      inputFormatters: [
                        TextInputFormatter.withFunction((oldValue, newValue) =>
                            RegExp(r"^[a-zA-Z ]*$").hasMatch(newValue.text)
                                ? newValue
                                : oldValue)
                      ],
                    ),
                    RSTextField(
                        label: 'Land area *',
                        hint: 'in Acers',
                        initialData:
                            controller.formDataParams.landArea.isNotEmpty
                                ? controller.formDataParams.landArea
                                : null,
                        onChange: (value) => controller.formDataParams =
                            controller.formDataParams.copyWith(landArea: value),
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          TextInputFormatter.withFunction(
                              (oldValue, newValue) =>
                                  RegExp(r"^[0-9]*[.]?[0-9]*$")
                                          .hasMatch(newValue.text)
                                      ? newValue
                                      : oldValue)
                        ],
                        validation: (value) =>
                            cannotBeEmpty(value: value, name: 'Land area')),
                    Obx(
                      () => GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => controller.interested.value =
                            !controller.interested.value,
                        child: AbsorbPointer(
                          child: RadioListTile(
                              value: true,
                              groupValue: controller.interested.value,
                              title: const Text(
                                  'Is farmer interested in Organic Farming?'),
                              onChanged: (value) {
                                controller.interested.value =
                                    !controller.interested.value;
                              }),
                        ),
                      ),
                    ),
                    RSElevatedButton(
                      title: 'Submit',
                      action: () {
                        if (controller.formKey.currentState?.validate() ??
                            false) {
                          controller.formDataParams = controller.formDataParams
                              .copyWith(
                                  address:
                                      '${controller.address},${controller.selectedVillage},${controller.selectedTaluka},${controller.selectedDistrict},${controller.state},${controller.pin.value}');
                          Get.dialog(const ConfirmDialog());
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
            );
          }),
        ),
      ),
    );
  }
}
