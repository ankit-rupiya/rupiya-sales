import 'package:aveo_api/aveo_api.dart';
import 'package:sales/constants/api_endpoints.dart';
import 'package:sales/constants/typedefs.dart';

class LocationRepository {
  static Future<void> sendLocation(
      {required Map<String, dynamic> params,
      required NetworkResponse onSuccess,
      NetworkResponse? onError}) async {
    ApiCall.instance.rest(
      params: params,
      serviceUrl: ApiEndpoints.salesmanLocation,
      showLoader: false,
      methodType: RestMethod.post,
      success: (code, data) => onSuccess(code, data),
      error: (statusCode, error) => onError?.call(statusCode, error),
    );
  }
}
