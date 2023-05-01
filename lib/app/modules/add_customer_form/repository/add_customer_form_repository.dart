import 'package:aveo_api/aveo_api.dart';
import 'package:sales/app/data/form_data_model.dart';
import 'package:sales/constants/api_endpoints.dart';
import 'package:sales/constants/typedefs.dart';

class AddCustomerFormRepository {
  static void addCustomer(
      {required FormDataParams formData,
      required NetworkResponse onSuccess,
      NetworkResponse? onError}) async {
    ApiCall.instance.rest(
      params: formData.toJson(),
      serviceUrl: ApiEndpoints.addCustomerData,
      showLoader: true,
      methodType: RestMethod.post,
      success: (code, data) => onSuccess(code, data),
      error: (statusCode, error) => onError?.call(statusCode, error),
    );
  }

  static void getPINData(
      {required String pin,
      required NetworkResponse onSuccess,
      NetworkResponse? onError}) {
    ApiCall.instance.rest(
      params: {},
      serviceUrl: ApiEndpoints.pinData(pin),
      showLoader: true,
      methodType: RestMethod.get,
      success: (code, data) => onSuccess(code, data),
      error: (statusCode, error) => onError?.call(statusCode, error),
    );
  }
}
