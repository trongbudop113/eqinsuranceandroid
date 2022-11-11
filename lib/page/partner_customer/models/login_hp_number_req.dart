class LoginHpNumberReq {
  String? sUserName;
  String? sPassword;
  String? sHpNumber;

  LoginHpNumberReq({this.sUserName, this.sPassword, this.sHpNumber});

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_HpNumber': this.sHpNumber,
    };
  }
}