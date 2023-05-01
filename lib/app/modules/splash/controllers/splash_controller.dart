import 'package:get/get.dart';
import 'package:sales/app/routes/app_pages.dart';
import 'package:sales/constants/enums.dart';
import 'package:sales/utils/get_storage.dart';

class SplashController extends GetxController {
  @override
  void onReady() {
    bool isAuth = Storage.read(UserFields.userName.name) == null;
    Future.delayed(2.seconds, () {
      Get.offAllNamed(isAuth ? Routes.AUTH : Routes.HOME);
    });
    super.onReady();
  }
}
