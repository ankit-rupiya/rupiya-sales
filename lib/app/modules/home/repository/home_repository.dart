import 'package:aveo_api/aveo_api.dart';
import 'package:sales/app/data/sales_params.dart';
import 'package:sales/constants/api_endpoints.dart';
import 'package:sales/constants/typedefs.dart';

class HomeRepository {
  static void getSalesManData(
      {required SalesParams salesParams,
      required NetworkResponse onSuccess,
      NetworkResponse? onError}) async {
    ApiCall.instance.rest(
      params: salesParams.toJson(),
      serviceUrl: ApiEndpoints.salesmanSales,
      showLoader: false,
      methodType: RestMethod.post,
      success: (code, data) => onSuccess(code, data),
      error: (statusCode, error) => onError?.call(statusCode, error),
    );
  }

  static void getSalesTeamData(
      {required SalesParams salesParams,
      required NetworkResponse onSuccess,
      NetworkResponse? onError}) async {
    ApiCall.instance.rest(
      params: salesParams.toJson(),
      serviceUrl: ApiEndpoints.teamSales,
      showLoader: false,
      methodType: RestMethod.post,
      success: (code, data) => onSuccess(code, data),
      error: (statusCode, error) => onError?.call(statusCode, error),
    );
  }
}
