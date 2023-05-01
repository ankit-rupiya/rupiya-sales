import 'package:get/get.dart';
import 'package:sales/app/modules/home/controllers/location_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<LocationController>(
      () => LocationController(),
    );
  }
}
