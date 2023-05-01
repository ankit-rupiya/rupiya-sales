import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/data/form_data_model.dart';
import 'package:sales/app/data/invalid_pin_model.dart';
import 'package:sales/app/data/valid_pin_model.dart';
import 'package:sales/app/modules/add_customer_form/repository/add_customer_form_repository.dart';
import 'package:sales/app/modules/home/controllers/home_controller.dart';
import 'package:sales/constants/message_type.dart';
import 'package:sales/core/snack_bar.dart';
import 'package:sales/utils/validations.dart';

class AddCustomerFormController extends GetxController {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: 'add leads');
  RxBool showAddress = false.obs;
  String address = '';
  String selectedVillage = '';
  String selectedTaluka = '';
  String selectedDistrict = '';
  String state = '';
  List<String> possibilities = [];
  List<String> villagesString = [];
  List<DropdownMenuItem<String>> possibilitiesMenuEntries = [];
  List<DropdownMenuItem<String>> villagesMenuEntries = [];
  RxBool interested = false.obs;
  // List<String> taluka = [];
  // List<String> district = [];
  RxString pin = ''.obs;
  FormDataParams formDataParams = FormDataParams(
    customerFirstName: '',
    customerLastName: '',
    mobileNo: '',
    address: '',
    cropName: '',
    landArea: '',
    interested: '0',
  );

  @override
  void onInit() {
    debounce(pin, (value) {
      if (validatePIN(value) == null) {
        getPinData(value);
      } else {
        showAddress.value = false;
      }
    });
    ever(showAddress, (value) {
      if (value) {
        return;
      } else {
        address = '';
        selectedVillage = '';
        selectedTaluka = '';
        selectedDistrict = '';
        state = '';
      }
    });
    ever(
        interested,
        (value) => formDataParams =
            formDataParams.copyWith(interested: value ? '1' : '0'));
    super.onInit();
  }

  void addCustomerDetails() {
    if (address.isEmpty ||
        selectedVillage.isEmpty ||
        selectedTaluka.isEmpty ||
        selectedDistrict.isEmpty ||
        state.isEmpty) {
      invokeSnackBar(message: 'Please finish adding address');
    } else {
      if (formKey.currentState?.validate() ?? false) {
        AddCustomerFormRepository.addCustomer(
          formData: formDataParams,
          onSuccess: (code, data) {
            invokeSnackBar(message: data['msg']);
            interested.value = false;
            state = '';
            formDataParams = FormDataParams(
              customerFirstName: '',
              customerLastName: '',
              mobileNo: '',
              address: '',
              cropName: '',
              landArea: '',
              interested: '0',
            );
            update();
            Get.find<HomeController>().getAllData();
          },
          onError: (statusCode, data) => invokeSnackBar(
              message: data['msg'] ?? data['message'],
              type: SnackBarType.error),
        );
      }
    }
  }

  void getPinData(String pin) {
    AddCustomerFormRepository.getPINData(
      pin: pin,
      onSuccess: (code, listJson) {
        try {
          Set<String> tempSet = {};
          Map<String, dynamic> json = listJson.first;
          ValidPinResponse data = ValidPinResponse.fromJson(json);
          state = data.postOffice!.first.state!;
          for (PostOffice element in data.postOffice!) {
            (element.block?.isNotEmpty ?? false)
                ? tempSet.add(element.block!)
                : null;
            (element.district?.isNotEmpty ?? false)
                ? tempSet.add(element.district!)
                : null;
            (element.division?.isNotEmpty ?? false)
                ? tempSet.add(element.division!)
                : null;
            (element.name?.isNotEmpty ?? false)
                ? villagesString.add(element.name!)
                : null;
          }
          villagesString = villagesString.toSet().toList();
          villagesMenuEntries = villagesString
              .map<DropdownMenuItem<String>>((element) =>
                  DropdownMenuItem<String>(
                      value: element, child: Text(element)))
              .toList();
          possibilities = tempSet.toList();
          possibilitiesMenuEntries = possibilities
              .map<DropdownMenuItem<String>>((element) =>
                  DropdownMenuItem<String>(
                      value: element, child: Text(element)))
              .toList();
          showAddress.value = true;
        } catch (_) {
          try {
            Map<String, dynamic> json = listJson.first;
            InvalidPinResponse data = InvalidPinResponse.fromJson(json);
            invokeSnackBar(message: data.message ?? 'Something went wrong');
          } catch (_) {
            invokeSnackBar(message: 'Something went wrong');
          }
        }
      },
      onError: (code, data) {
        invokeSnackBar(message: 'Something went wrong');
      },
    );
  }
}
