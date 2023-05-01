import 'package:aveo_api/aveo_api.dart';
import 'package:sales/app/data/log_out_params.dart';
import 'package:sales/app/data/user.dart';
import 'package:sales/constants/api_endpoints.dart';
import 'package:sales/constants/typedefs.dart';

class AuthRepository {
  static Future<void> login(
      {required String username,
      required String password,
      required NetworkResponse onSuccess,
      NetworkResponse? onError}) async {
    ApiCall.instance.rest(
      params: {'email': username, 'password': password},
      serviceUrl: ApiEndpoints.login,
      showLoader: true,
      methodType: RestMethod.post,
      success: (code, data) => onSuccess(code, data),
      error: (statusCode, error) => onError?.call(statusCode, error),
    );
  }

  static Future<void> logout(
      {required User user,
      required NetworkResponse onSuccess,
      NetworkResponse? onError}) async {
    ApiCall.instance.rest(
      params: LogOutParams(deviceID: 'mobile', cId: user.cId, traID: user.txID)
          .toJson(),
      header: {'clientcode': '123'},
      serviceUrl: ApiEndpoints.logOut,
      showLoader: true,
      methodType: RestMethod.post,
      success: (code, data) => onSuccess(code, data),
      error: (statusCode, error) => onError?.call(statusCode, error),
    );
  }
}
