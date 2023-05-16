import 'package:get/get.dart';

import '../controllers/update_customer_controller.dart';

class UpdateCustomerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UpdateCustomerController>(
      () => UpdateCustomerController(),
    );
  }
}
