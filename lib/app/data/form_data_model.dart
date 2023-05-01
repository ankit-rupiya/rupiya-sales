import 'package:sales/constants/enums.dart';
import 'package:sales/utils/get_storage.dart';

class FormDataParams {
  String salesmanName = Storage.read<String>(UserFields.userName.name) ?? '';
  String customerFirstName;
  String customerMiddleName;
  String customerLastName;
  String mobileNo;
  String address;
  String cropName;
  String landArea;
  String interested;

  FormDataParams({
    required this.customerFirstName,
    this.customerMiddleName = '',
    required this.customerLastName,
    required this.mobileNo,
    required this.address,
    required this.cropName,
    required this.landArea,
    required this.interested,
  });

  factory FormDataParams.fromJson(Map<String, dynamic> json) {
    return FormDataParams(
      customerFirstName: json['customer_first_name'],
      customerMiddleName: json['customer_middle_name'],
      customerLastName: json['customer_last_name'],
      mobileNo: json['mobile_no'],
      address: json['address'],
      cropName: json['crop_name'],
      landArea: json['land_area'],
      interested: json['intrested'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salesman_name'] = salesmanName;
    data['customer_first_name'] = customerFirstName;
    data['customer_middle_name'] = customerMiddleName;
    data['customer_last_name'] = customerLastName;
    data['mobile_no'] = mobileNo;
    data['address'] = address;
    data['crop_name'] = cropName;
    data['land_area'] = landArea;
    data['intrested'] = interested;
    return data;
  }

  FormDataParams copyWith({
    String? customerFirstName,
    String? customerMiddleName,
    String? customerLastName,
    String? mobileNo,
    String? address,
    String? cropName,
    String? landArea,
    String? interested,
  }) {
    return FormDataParams(
      customerFirstName: customerFirstName ?? this.customerFirstName,
      customerMiddleName: customerMiddleName ?? this.customerMiddleName,
      customerLastName: customerLastName ?? this.customerLastName,
      mobileNo: mobileNo ?? this.mobileNo,
      address: address ?? this.address,
      cropName: cropName ?? this.cropName,
      landArea: landArea ?? this.landArea,
      interested: interested ?? this.interested,
    );
  }
}
