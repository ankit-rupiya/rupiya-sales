import 'package:aveo_api/aveo_api.dart';
import 'package:intl/intl.dart';
import 'package:sales/app/modules/auth/controllers/auth_controller.dart';
import 'package:sales/constants/api_endpoints.dart';
import 'package:sales/constants/typedefs.dart';

class MapTrackRepository {
  static void getSalesmanList(
      {required NetworkResponse onSuccess, NetworkResponse? onError}) async {
    AuthController ac = AuthController.to;
    String role =
        '${ac.user.value!.department} ${ac.user.value!.authorization.viewName}';
    ApiCall.instance.rest(
      params: {},
      serviceUrl: ApiEndpoints.usernameList(role),
      showLoader: true,
      methodType: RestMethod.get,
      success: (code, data) => onSuccess(code, data),
      error: (statusCode, error) => onError?.call(statusCode, error),
    );
  }

  static void getSalesmanMapData(
      {required String salesman,
      required DateTime datetime,
      required NetworkResponse onSuccess,
      NetworkResponse? onError}) async {
    ApiCall.instance.rest(
      params: {},
      serviceUrl: ApiEndpoints.locationLogs(
          salesman, DateFormat('yyyy-MM-dd').format(datetime)),
      showLoader: false,
      methodType: RestMethod.get,
      success: (code, data) => onSuccess(code, data),
      error: (statusCode, error) => onError?.call(statusCode, error),
    );
  }
}
