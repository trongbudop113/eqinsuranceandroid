class GetPartnerCustomerReq {
  String? sUserName;
  String? sPassword;
  String? sHpNumber;

  GetPartnerCustomerReq({this.sUserName, this.sPassword, this.sHpNumber});

  GetPartnerCustomerReq.fromJson(Map<String, dynamic> json) {
    sUserName = json['_UserName'];
    sPassword = json['_Password'];
    sHpNumber = json['_HpNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_UserName'] = this.sUserName;
    data['_Password'] = this.sPassword;
    data['_HpNumber'] = this.sHpNumber;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_HpNumber': this.sHpNumber,
    };
  }
}