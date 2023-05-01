class LogOutParams {
  String deviceID;
  String cId;
  String traID;

  LogOutParams(
      {required this.deviceID, required this.cId, required this.traID});

  factory LogOutParams.fromJson(Map<String, dynamic> json) {
    return LogOutParams(
      deviceID: json['Device_ID'],
      cId: json['c_id'],
      traID: json['Tra_ID'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Device_ID'] = deviceID;
    data['c_id'] = cId;
    data['Tra_ID'] = traID;
    return data;
  }
}
