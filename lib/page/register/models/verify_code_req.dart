class VerifyCodeReq {
  String? sUserName;
  String? sPassword;
  String? sUserID;
  String? sMobileNo;
  String? sOTP;

  VerifyCodeReq({this.sUserName, this.sPassword, this.sUserID, this.sMobileNo, this.sOTP});

  VerifyCodeReq.fromJson(Map<String, dynamic> json) {
    sUserName = json['_UserName'];
    sPassword = json['_Password'];
    sUserID = json['_UserID'];
    sMobileNo = json['_MobileNo'];
    sOTP = json['_OTP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_UserName'] = this.sUserName;
    data['_Password'] = this.sPassword;
    data['_UserID'] = this.sUserID;
    data['_MobileNo'] = this.sMobileNo;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_UserID': this.sUserID,
      '_MobileNo': this.sMobileNo,
      '_OTP': this.sOTP,
    };
  }
}