class LogOutResponse {
  String? status;
  int? errorCode;
  String? msg;
  List<Data>? data;

  LogOutResponse({this.status, this.errorCode, this.msg, this.data});

  LogOutResponse.fromJson(Map<String, dynamic> json) {
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
  Token? token;

  Data({this.token});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (token != null) {
      data['token'] = token!.toJson();
    }
    return data;
  }
}

class Token {
  String? status;
  String? type;
  String? msg;

  Token({this.status, this.type, this.msg});

  Token.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    type = json['type'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['type'] = type;
    data['msg'] = msg;
    return data;
  }
}
