class InputCodeReq {
  String? sUserName;
  String? sPassword;
  String? sUserID;
  String? sMobileNo;
  String? sOTP;
  String? sPin;
  String? sManufacturer;
  String? sModel;
  String? sOsName;
  String? sOsVersion;

  InputCodeReq({this.sUserName, this.sPassword, this.sUserID, this.sMobileNo, this.sOsVersion, this.sOsName, this.sModel, this.sManufacturer, this.sPin, this.sOTP});

  InputCodeReq.fromJson(Map<String, dynamic> json) {
    sUserName = json['_UserName'];
    sPassword = json['_Password'];
    sUserID = json['_UserID'];
    sMobileNo = json['_MobileNo'];
    sOTP = json['_OTP'];
    sPin = json['_Pin'];
    sManufacturer = json['_manufacturer'];
    sModel = json['_model'];
    sOsName = json['_osname'];
    sOsVersion = json['_osversion'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_UserName'] = this.sUserName;
    data['_Password'] = this.sPassword;
    data['_UserID'] = this.sUserID;
    data['_MobileNo'] = this.sMobileNo;
    data['_OTP'] = this.sOTP;
    data['_Pin'] = this.sPin;
    data['_manufacturer'] = this.sManufacturer;
    data['_model'] = this.sModel;
    data['_osname'] = this.sOsName;
    data['_osversion'] = this.sOsVersion;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_UserID': this.sUserID,
      '_MobileNo': this.sMobileNo,
      '_OTP': this.sOTP,
      '_Pin': this.sPin,
      '_manufacturer': this.sManufacturer,
      '_model': this.sModel,
      '_osname': this.sOsName,
      '_osversion': this.sOsVersion,
    };
  }
}