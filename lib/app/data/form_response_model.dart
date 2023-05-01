class FormResponse {
  String? status;
  int? errorCode;
  String? msg;
  List<Data>? data;

  FormResponse({this.status, this.errorCode, this.msg, this.data});

  FormResponse.fromJson(Map<String, dynamic> json) {
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
  String? trxId;

  Data({this.trxId});

  Data.fromJson(Map<String, dynamic> json) {
    trxId = json['trx_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trx_id'] = trxId;
    return data;
  }
}
