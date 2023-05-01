import 'package:get/get.dart';
import 'package:sales/constants/message_type.dart';

void invokeSnackBar(
    {required String message, SnackBarType type = SnackBarType.success}) {
  Get.closeCurrentSnackbar().then((_) => Get.showSnackbar(GetSnackBar(
        duration: const Duration(seconds: 3),
        message: message,
        backgroundColor: type.background,
      )));
}
