import 'package:get/get.dart';

import '../controllers/add_customer_form_controller.dart';

class AddCustomerFormBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddCustomerFormController>(
      () => AddCustomerFormController(),
    );
  }
}
