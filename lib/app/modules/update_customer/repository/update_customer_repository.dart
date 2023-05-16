import 'package:aveo_api/aveo_api.dart';
import 'package:sales/app/data/update_customer_params.dart';
import 'package:sales/constants/api_endpoints.dart';
import 'package:sales/constants/typedefs.dart';

class UpdateCustomerRepository {
  static Future<void> updateCustomer(
      {required UpdateCustomerParams params,
      required NetworkResponse onSuccess,
      NetworkResponse? onError}) async {
    ApiCall.instance.rest(
      params: params.toJson(),
      serviceUrl: ApiEndpoints.updateCustomerData,
      showLoader: true,
      methodType: RestMethod.put,
      success: (code, data) => onSuccess(code, data),
      error: (statusCode, error) => onError?.call(statusCode, error),
    );
  }
}
