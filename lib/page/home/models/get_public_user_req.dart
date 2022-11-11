class GetPublicUserReq {
  String? sUserName;
  String? sPassword;

  GetPublicUserReq({this.sUserName, this.sPassword});

  GetPublicUserReq.fromJson(Map<String, dynamic> json) {
    sUserName = json['_UserName'];
    sPassword = json['_Password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_UserName'] = this.sUserName;
    data['_Password'] = this.sPassword;
    return data;
  }

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
    };
  }
}