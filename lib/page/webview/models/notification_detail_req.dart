class NotificationDetailReq {
  String? sUserName;
  String? sPassword;
  String? sEnvironment;

  NotificationDetailReq({this.sUserName, this.sPassword, this.sEnvironment});

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_Environment': this.sEnvironment
    };
  }
}

class GetAPIInfoReq {
  String? sUserName;
  String? sPassword;
  String? sEnvironment;

  GetAPIInfoReq({this.sUserName, this.sPassword, this.sEnvironment});

  Map<String, dynamic> toMap() {
    return {
      '_UserName': this.sUserName,
      '_Password': this.sPassword,
      '_Environment': this.sEnvironment
    };
  }
}

class ApproveReq {
  String? RequestToken;

  ApproveReq({this.RequestToken});

  Map<String, dynamic> toMap() {
    return {
      'RequestToken': this.RequestToken,
    };
  }
}