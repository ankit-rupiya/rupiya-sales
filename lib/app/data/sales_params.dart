import 'package:intl/intl.dart';

class SalesParams {
  String? salesmanName;
  DateTime startDate;
  DateTime endDate;

  SalesParams(
      {this.salesmanName, required this.startDate, required this.endDate});

  Map<String, dynamic> toJson() {
    DateFormat dateFormat = DateFormat('yyyy-MM-dd');
    final Map<String, dynamic> data = <String, dynamic>{};
    if (salesmanName != null) {
      data['salesman_name'] = salesmanName;
    }
    data['start_date'] = dateFormat.format(startDate);
    data['end_date'] = dateFormat.format(endDate);
    return data;
  }
}
