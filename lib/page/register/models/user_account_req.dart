class UserAccountReq {
  String? sUserName;
  String? sPassword;
  String? sUserID;
  String? sUserPass;

  UserAccountReq({this.sUserName, this.sPassword, this.sUserID, this.sUserPass});

  UserAccountReq.fromJson(Map<String, dynamic> json) {
    sUserName = json['_UserName'];
    sPassword = json['_Password'];
    sUserID = json['_UserID'];
    sUserPass = json['_UserPass'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_UserName'] = this.sUserName;
    data['_Password'] = this.sPassword;
    data['_UserID'] = this.sUserID;
    data['_UserPass'] = this.sUserPass;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_UserID': this.sUserID,
      '_UserPass': this.sUserPass,
    };
  }
}