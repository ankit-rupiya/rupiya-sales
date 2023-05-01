class SalesResponse {
  String? status;
  int? errorCode;
  String? msg;
  List<Data>? data;

  SalesResponse({this.status, this.errorCode, this.msg, this.data});

  SalesResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errorCode = json['error_code'];
    msg = json['msg'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['error_code'] = errorCode;
    data['msg'] = msg;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  Details? details;

  Data({this.details});

  Data.fromJson(Map<String, dynamic> json) {
    details =
        json['details'] != null ? Details.fromJson(json['details']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (details != null) {
      data['details'] = details!.toJson();
    }
    return data;
  }
}

class Details {
  int? countEndDateDetails;
  List<EndDateDetails>? endDateDetails;
  int? countPreviousWeekDetails;
  List<EndDateDetails>? previousWeekDetails;
  int? countStartToEndDateDetails;
  List<EndDateDetails>? startToEndDateDetails;

  Details(
      {this.countEndDateDetails,
      this.endDateDetails,
      this.countPreviousWeekDetails,
      this.previousWeekDetails,
      this.countStartToEndDateDetails,
      this.startToEndDateDetails});

  Details.fromJson(Map<String, dynamic> json) {
    countEndDateDetails = json['count_end_date_details'];
    if (json['end_date_details'] != null) {
      endDateDetails = <EndDateDetails>[];
      json['end_date_details'].forEach((v) {
        endDateDetails!.add(EndDateDetails.fromJson(v));
      });
    }
    countPreviousWeekDetails = json['count_previous_week_details'];
    if (json['previous_week_details'] != null) {
      previousWeekDetails = <EndDateDetails>[];
      json['previous_week_details'].forEach((v) {
        previousWeekDetails!.add(EndDateDetails.fromJson(v));
      });
    }
    countStartToEndDateDetails = json['count_start_to_end_date_details'];
    if (json['start_to_end_date_details'] != null) {
      startToEndDateDetails = <EndDateDetails>[];
      json['start_to_end_date_details'].forEach((v) {
        startToEndDateDetails!.add(EndDateDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count_end_date_details'] = countEndDateDetails;
    if (endDateDetails != null) {
      data['end_date_details'] =
          endDateDetails!.map((v) => v.toJson()).toList();
    }
    data['count_previous_week_details'] = countPreviousWeekDetails;
    if (previousWeekDetails != null) {
      data['previous_week_details'] =
          previousWeekDetails!.map((v) => v.toJson()).toList();
    }
    data['count_start_to_end_date_details'] = countStartToEndDateDetails;
    if (startToEndDateDetails != null) {
      data['start_to_end_date_details'] =
          startToEndDateDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class EndDateDetails {
  int? uniqueId;
  String? trxId;
  String? salesmanName;
  String? cFirstName;
  String? cMiddleName;
  String? cLastName;
  String? cMobileNo;
  String? cFarmAddress;
  String? cropName;
  String? landArea;
  String? createdDatetime;
  int interested;

  EndDateDetails(
      {this.uniqueId,
      this.trxId,
      this.salesmanName,
      this.cFirstName,
      this.cMiddleName,
      this.cLastName,
      this.cMobileNo,
      this.cFarmAddress,
      this.cropName,
      this.landArea,
      this.createdDatetime,
      this.interested = 0});

  // EndDateDetails.fromJson(Map<String, dynamic> json) {
  //   uniqueId = json['unique_id'];
  //   trxId = json['trx_id'];
  //   salesmanName = json['salesman_name'];
  //   cFirstName = json['c_first_name'];
  //   cMiddleName = json['c_middle_name'];
  //   cLastName = json['c_last_name'];
  //   cMobileNo = json['c_mobile_no'];
  //   cFarmAddress = json['c_farm_address'];
  //   cropName = json['crop_name'];
  //   landArea = json['land_area'];
  //   createdDatetime = json['created_datetime'];
  //   interested = json['interested'] ?? 0;
  // }

  factory EndDateDetails.fromJson(Map<String, dynamic> json) {
    return EndDateDetails(
      uniqueId: json['unique_id'],
      trxId: json['trx_id'],
      salesmanName: json['salesman_name'],
      cFirstName: json['c_first_name'],
      cMiddleName: json['c_middle_name'],
      cLastName: json['c_last_name'],
      cMobileNo: json['c_mobile_no'],
      cFarmAddress: json['c_farm_address'],
      cropName: json['crop_name'],
      landArea: json['land_area'],
      createdDatetime: json['created_datetime'],
      interested: json['intrested'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['trx_id'] = trxId;
    data['salesman_name'] = salesmanName;
    data['c_first_name'] = cFirstName;
    data['c_middle_name'] = cMiddleName;
    data['c_last_name'] = cLastName;
    data['c_mobile_no'] = cMobileNo;
    data['c_farm_address'] = cFarmAddress;
    data['crop_name'] = cropName;
    data['land_area'] = landArea;
    data['created_datetime'] = createdDatetime;
    data['intrested'] = interested;
    return data;
  }
}
