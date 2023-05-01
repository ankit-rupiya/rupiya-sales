class InvalidPinResponse {
  String? status;
  String? message;
  String? requestUri;

  InvalidPinResponse({this.status, this.message, this.requestUri});

  InvalidPinResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    requestUri = json['RequestUri'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['RequestUri'] = requestUri;
    return data;
  }
}
