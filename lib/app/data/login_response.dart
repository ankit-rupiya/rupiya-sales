class LoginResponse {
  String? status;
  int? errorCode;
  String? msg;
  List<Data>? data;

  LoginResponse({this.status, this.errorCode, this.msg, this.data});

  LoginResponse.fromJson(Map<String, dynamic> json) {
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
  String? cId;
  String? trxId;
  String? role;

  Data({this.cId, this.trxId, this.role});

  Data.fromJson(Map<String, dynamic> json) {
    cId = json['c_id'];
    trxId = json['trx_id'];
    role = json['role'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['c_id'] = cId;
    data['trx_id'] = trxId;
    data['role'] = role;
    return data;
  }
}
