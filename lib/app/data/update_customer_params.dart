class UpdateCustomerParams {
  String? salesmanName;
  String? trxId;
  String? address;
  String? cropName;
  String? landArea;
  String? interested;

  UpdateCustomerParams(
      {this.salesmanName,
      this.trxId,
      this.address,
      this.cropName,
      this.landArea,
      this.interested});

  UpdateCustomerParams.fromJson(Map<String, dynamic> json) {
    salesmanName = json['salesman_name'];
    trxId = json['trx_id'];
    address = json['address'];
    cropName = json['crop_name'];
    landArea = json['land_area'];
    interested = json['intrested'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['salesman_name'] = salesmanName;
    data['trx_id'] = trxId;
    data['address'] = address;
    data['crop_name'] = cropName;
    data['land_area'] = landArea;
    data['intrested'] = interested;
    return data;
  }
}
