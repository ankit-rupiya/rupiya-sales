class LocationLogsResponse {
  String? status;
  int? errorCode;
  String? msg;
  List<Data>? data;

  LocationLogsResponse({this.status, this.errorCode, this.msg, this.data});

  LocationLogsResponse.fromJson(Map<String, dynamic> json) {
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
  List<LocationDetails>? locationDetails;

  Data({this.locationDetails});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['location_details'] != null) {
      locationDetails = <LocationDetails>[];
      json['location_details'].forEach((v) {
        locationDetails!.add(LocationDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (locationDetails != null) {
      data['location_details'] =
          locationDetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LocationDetails {
  int? uniqueId;
  String? salesmanName;
  String? sLatitude;
  String? sLongitude;
  String? sManualTimerstamp;
  String? sTrackDatetime;

  LocationDetails(
      {this.uniqueId,
      this.salesmanName,
      this.sLatitude,
      this.sLongitude,
      this.sManualTimerstamp,
      this.sTrackDatetime});

  LocationDetails.fromJson(Map<String, dynamic> json) {
    uniqueId = json['unique_id'];
    salesmanName = json['salesman_name'];
    sLatitude = json['s_latitude'];
    sLongitude = json['s_longitude'];
    sManualTimerstamp = json['s_manual_timerstamp'];
    sTrackDatetime = json['s_track_datetime'];
  }

  LocationUIData toLocationUIData({int count = 1}) {
    return LocationUIData(
        sLatitude: sLatitude!, sLongitude: sLongitude!, count: count);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unique_id'] = uniqueId;
    data['salesman_name'] = salesmanName;
    data['s_latitude'] = sLatitude;
    data['s_longitude'] = sLongitude;
    data['s_manual_timerstamp'] = sManualTimerstamp;
    data['s_track_datetime'] = sTrackDatetime;
    return data;
  }
}

class LocationUIData {
  final String sLatitude;
  final String sLongitude;
  final int count;
  const LocationUIData(
      {required this.sLatitude, required this.sLongitude, this.count = 1});

  LocationUIData incrementCount() {
    return LocationUIData(
        sLatitude: sLatitude, sLongitude: sLongitude, count: count + 1);
  }
}
