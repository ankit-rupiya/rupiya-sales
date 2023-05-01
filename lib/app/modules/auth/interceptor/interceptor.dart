// ignore_for_file: implementation_imports, depend_on_referenced_packages

import 'package:dio/src/options.dart';
import 'package:dio/src/dio_mixin.dart';
import 'package:get/get.dart' as gget;
import 'package:sales/app/modules/auth/controllers/auth_controller.dart';
import 'package:sales/app/routes/app_pages.dart';
import 'package:sales/constants/api_endpoints.dart';
import 'package:sales/utils/get_storage.dart';

class RupiyaAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (AuthController.to.user.value == null) {
      options.headers.addAll({'Tra-ID': '123', 'Device-ID': 'mobile'});
    } else if (options.path == ApiEndpoints.logOut) {
    } else {
      options.headers.addAll({
        'Tra-ID': AuthController.to.user.value!.txID,
        'Device-ID': 'mobile'
      });
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(resp, ResponseInterceptorHandler handler) {
    if (resp.statusCode == 400 &&
        resp.data['error_code'] == 400 &&
        resp.data['msg'] == 'Invalid access_key!!') {
      gget.Get.find<AuthController>().user.value = null;
      Storage.deleteAll();
      gget.Get.offAllNamed(Routes.AUTH);
    }
    super.onResponse(resp, handler);
  }
}
