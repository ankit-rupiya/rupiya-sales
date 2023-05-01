class LocationParams {
  String username;
  String latitude;
  String longitude;
  String timestamp;

  LocationParams({
    required this.username,
    required this.latitude,
    required this.longitude,
    required this.timestamp,
  });

  factory LocationParams.fromJson(Map<String, dynamic> json) {
    return LocationParams(
      username: json['salesman_name'],
      latitude: json['s_lat'],
      longitude: json['s_long'],
      timestamp: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['salesman_name'] = username;
    data['s_lat'] = latitude;
    data['s_long'] = longitude;
    data['time'] = timestamp;
    return data;
  }
}
