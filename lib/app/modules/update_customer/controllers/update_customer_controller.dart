import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sales/app/data/team_sales_response.dart';
import 'package:sales/app/modules/home/controllers/home_controller.dart';
import 'package:sales/app/modules/update_customer/repository/update_customer_repository.dart';
import 'package:sales/app/routes/app_pages.dart';
import 'package:sales/constants/message_type.dart';
import 'package:sales/core/dialog.dart';
import 'package:sales/core/elevated_buttons.dart';
import 'package:sales/core/snack_bar.dart';

class UpdateCustomerController extends GetxController {
  EndDateDetails data = Get.arguments;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RxBool interested = false.obs;

  Future<void> updateCustomer() async {
    UpdateCustomerRepository.updateCustomer(
        params: data.toUpdateParams(),
        onSuccess: (_, __) {
          Get.dialog(RSDialog(message: 'Data updated Successfully', actions: [
            RSElevatedButton(
              title: 'Ok',
              action: () {
                Get.offNamedUntil(Routes.HOME, (route) => false);
                Get.find<HomeController>().getAllData();
              },
            )
          ]));
        },
        onError: (_, error) {
          invokeSnackBar(message: error['msg'], type: SnackBarType.error);
        });
  }

  @override
  void onInit() {
    interested.value = data.interested == 1;
    super.onInit();
  }
}
